package com.jump.Jumpstart.Controller;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jump.Jumpstart.Entity.Product;
import com.jump.Jumpstart.Entity.Purchase;
import com.jump.Jumpstart.Entity.User;
import com.jump.Jumpstart.Service.EmailSenderService;
import com.jump.Jumpstart.Service.PaypalService;
import com.jump.Jumpstart.Service.ProductService;
import com.jump.Jumpstart.Service.PurchaseService;
import com.jump.Jumpstart.Service.UserService;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;

@Controller
public class PaypalController {

	@Autowired
	PaypalService service;

	@Autowired
	PurchaseService dService;

	@Autowired
	ProductService prodService;

	@Autowired
	EmailSenderService emailSender;

	@Autowired
	UserService userService;

	public static final String SUCCESS_URL = "success";
	public static final String CANCEL_URL = "pay/cancel";

	@GetMapping("/paypal")
	public String home(@RequestParam long prodId, Model model) {
		Product product_info = prodService.findProduct(prodId);

		List<Product> product = new ArrayList<Product>();
		product.add(product_info);

		model.addAttribute("product", product);

		return "Paypal/paypal";
	}

	@PostMapping("/pay")
	public String payment(@ModelAttribute("purchase") Purchase purchase, Principal principal, @RequestParam long prodId)
			throws UnsupportedEncodingException, MessagingException {
		try {
			String username = principal.getName();

			User user = userService.findLoginUser(username);
			
			String code = generateCode();
			
			Product product = prodService.findProduct(prodId);
			purchase.setDescription("Purchase of " + purchase.getCount() + "items of "+ product.getName());
			purchase.setAmount(purchase.getCount()*product.getPrice());
			purchase.setProduct(product);
			purchase.setUser(user);
			purchase.setCode(code);
			
			Payment payment = service.createPayment(purchase.getAmount(), purchase.getCurrency(), purchase.getMethod(),
					purchase.getIntent(), purchase.getDescription(), "http://localhost:8080/" + CANCEL_URL,
					"http://localhost:8080/" + SUCCESS_URL);

			dService.save(purchase);

			product.setSales(product.getSales() + purchase.getCount());
			product.setStock(product.getStock() - purchase.getCount());

			prodService.save(product);

			String toEmail = user.getEmail();
			String subject = "Thank you for your purchase AT Jumpstart";
			String body = "Dear " + user.getName() + ",\r\n" + "\r\n"
					+ "We are delighted to inform you that your order has been successfully processed.\r\n"
					+ "\r\n"
					+ "Your 6-digit code is" + purchase.getCode() +". Please keep it safe and use it to claim your order at " + purchase.getLocation() + "branch.\r\n"
					+ "\r\n"
					+ "We appreciate your trust in Jumpstart, the best ecommerce platform for your online business. We hope you enjoy our products and services, and we look forward to serving you again in the future.\r\n"
					+ "\r\n"
					+ "If you have any questions or feedback, please do not hesitate to contact us at support@jumpstart.com. We are always happy to hear from you.\r\n"
					+ "\r\n" + "Sincerely,\r\n" + "\r\n" + "Jumpstart Team";

			emailSender.sendEmail(toEmail, subject, body);

			for (Links link : payment.getLinks()) {
				if (link.getRel().equals("approval_url")) {
					return "redirect:" + link.getHref();
				}
			}

		} catch (PayPalRESTException e) {

			e.printStackTrace();
		}
		return "redirect:paypal";
	}

	public String generateCode() {
		Random rnd = new Random();
		int number = rnd.nextInt(999999);
		String code = String.format("%06d", number);
		return code;
	}

	@GetMapping(value = CANCEL_URL)
	public String cancelPay() {
		return "redirect:paypal";
	}

	@GetMapping(value = SUCCESS_URL)
	public String successPay(@RequestParam("paymentId") String paymentId, @RequestParam("PayerID") String payerId) {
		try {
			Payment payment = service.executePayment(paymentId, payerId);
			System.out.println(payment.toJSON());
			if (payment.getState().equals("approved")) {
				return "Users/confirmation";
			}
		} catch (PayPalRESTException e) {
			System.out.println(e.getMessage());
		}
		return "redirect:paypal";
	}

}
