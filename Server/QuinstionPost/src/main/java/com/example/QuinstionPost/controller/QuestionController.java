package com.example.QuinstionPost.controller;

import com.example.QuinstionPost.Dto.QuestionDto;
import com.example.QuinstionPost.Dto.ResponseDto;
import com.example.QuinstionPost.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;


@CrossOrigin("*")
@RestController
@RequestMapping("/question")
public class QuestionController {
    @Autowired
    QuestionService questionService;

    @PostMapping(value = "/addQuestion/{accountId}")
    QuestionDto addQuestion (@RequestBody QuestionDto question, @PathVariable("accountId") String accountId){
        return questionService.addQuestion(question, accountId);
    }

    @GetMapping(value = "/allQuestions")
    List<QuestionDto> viewAllQuestions (){
        return questionService.viewAllQuestions();
    }

    @GetMapping(value = "/listQuestionByCategory/{category}")
    List<QuestionDto> viewQuestionByCategory (@PathVariable("category") String category){
        return questionService.viewQuestionsByCategory(category);
    }

    @GetMapping(value = "/listQuestionByAccount/{accountId}")
    List<QuestionDto> viewQuestionByAccount (@PathVariable("accountId") String accountId){
        return questionService.viewQuestionsByCategory(accountId);
    }

    @GetMapping(value = "/listQuestionById/{questionId}")
    QuestionDto viewQuestionById (@PathVariable("questionId") String questionId){
        return questionService.viewQuestionsById(questionId);
    }



    @PostMapping(value = "/upVoteQuestion/{questionId}")
    void upVoteQuestion(@PathVariable("questionId") String questionId){
        questionService.upVote(questionId);

    }
    @PostMapping(value = "/downVoteQuestion/{questionId}")
    void downVoteQuestion(@PathVariable("questionId") String questionId){
        questionService.downVote(questionId);
    }

}
