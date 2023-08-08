package com.shop.app.servicecenter.inquiry.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;
import com.shop.app.servicecenter.inquiry.service.InquiryService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/servicecenter")
@Controller
public class InquiryController {

	@Autowired
	private InquiryService inquiryService;
	
	// 고객센터 (선모)
	@GetMapping("/service.do")
	public void serviceCenter() {
		
	}
	
	// 1:1 목록 조회 질문 (예라)
	@GetMapping("/inquiry/questionList.do")
	public void questionList(Question question, Model model) {
		List<Question> questions = inquiryService.findQuestionAll(question);
		model.addAttribute("questions", questions);
	}
	
	@GetMapping("/inquiry/questionDetail.do")
	public void questionDetail(@RequestParam int questionId, Model model) {
	    
	    Question question = new Question();
	    question.setId(questionId);

	    Question questions = inquiryService.findQuestionById(question);
	    model.addAttribute("questions", questions);
	    
	    Answer answer = new Answer();
	    answer.setQuestionId(questionId);

	    Answer answers = inquiryService.findQuestionAnswersById(answer);
	    model.addAttribute("answers", answers);
	}
	
	// 1:1 문의 작성 (예라)
	@GetMapping("/inquiry/questionCreate.do")
	public void questionCreate() {
		
	}
	
}
