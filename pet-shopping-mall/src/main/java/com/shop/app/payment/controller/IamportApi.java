package com.shop.app.payment.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.shop.app.order.service.OrderService;
import com.siot.IamportRestClient.IamportClient;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
@Component
@RequestMapping("/import")
public class IamportApi {
	@Value("${external.api.key}")
	private String apiKey;
	
	@Value("${external.api.secret}")
	private String apiSecret;
	
	private IamportClient iamportClient;
	
	public IamportApi() {
		this.iamportClient = new IamportClient(apiKey, apiSecret);
	}
	
	@Autowired
	OrderService orderService;
	
	public static final String IMPORT_TOKEN_URL = "https://api.iamport.kr/users/getToken";
	public static final String IMPORT_CANCEL_URL = "https://api.iamport.kr/payments/cancel";

	/**
	 * @author 김담희
	 * 아임포트 토큰을 받아오는 메소드
	 */
	public String getImportToken() {
		String result = "";
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_TOKEN_URL);
		Map<String, String> map = new HashMap<>();

		map.put("imp_key", this.getApiKey());
		map.put("imp_secret", this.getApiSecret());

		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(map)));
			HttpResponse response = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();

			String body = EntityUtils.toString(response.getEntity());
			JsonNode rootNode = mapper.readTree(body);
			JsonNode resNode = rootNode.get("response");
			
			result = resNode.get("access_token").asText();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	/**
	 * @author 김담희
	 * 환불하기 요청을 받았을 경우, 해당 주문 번호에 대하여 아임포트에 환불하기 요청을 보냄
	 * 환불 요청 결과가 정상 반환될 경우 로컬DB의 주문 취소 테이블에 insert
	 */
	@PostMapping("/refundOrder.do")
	public String refundOrder(@RequestParam String orderNo, RedirectAttributes redirectAttr,
			@RequestParam String isRefund) {
		
		String token = getImportToken();
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_CANCEL_URL);
		Map<String, String> map = new HashMap<>();

		post.setHeader("Authorization", token);
		map.put("merchant_uid", orderNo);
		String result = "";
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(map)));
			HttpResponse res = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			String enty = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(enty);
			
			result = rootNode.get("response").asText();
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (result.equals("null")) {
			redirectAttr.addFlashAttribute("msg", "환불 실패");
			return "redirect:/order/orderList.do";
		} else {
			orderService.insertCancelOrder(orderNo, isRefund);
			redirectAttr.addFlashAttribute("msg", "환불 성공");
			return "redirect:/order/orderList.do";
		}
	}
	
	
	
	/**
	 * @author 김담희
	 * Map을 List<NameValuePair>으로 형변환하는 메소드
	 */
	public List<NameValuePair> convertParameter(Map<String, String> paramMap) {
		List<NameValuePair> params = new ArrayList<>();
		for (Map.Entry<String, String> entry : paramMap.entrySet()) {
			params.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
		}
		return params;
	}
}
