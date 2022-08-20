package com.example.QuinstionPost.controller;

import com.example.QuinstionPost.Dto.AnswerDto;
import com.example.QuinstionPost.Dto.QuestionDto;
//import com.example.QuinstionPost.Dto.void;
import com.example.QuinstionPost.service.AnswerService;
import com.example.QuinstionPost.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("/answer")
public class AnswerController {

    @Autowired
    AnswerService answerService ;

    @PostMapping(value = "/addAnswer/{accountId}")
    AnswerDto addAnswer (@RequestBody AnswerDto answer, @PathVariable("accountId") String accountId){
        return answerService.addAnswer(answer, accountId);
    }

    @GetMapping(value = "/allAnswer/{questionId}")
    List<AnswerDto> viewAllQuestions (@PathVariable String questionId){
        return answerService.findByQuestionId(questionId);
    }

    @PostMapping(value = "/upVoteAnswer/{answerId}")
    void upVoteAnswer(@PathVariable("answerId") String answerId){
        answerService.upVote(answerId);

    }
    @PostMapping(value = "/downVoteAnswer/{answerId}")
    void downVoteAnswer(@PathVariable("answerId") String answerId){
        answerService.downVote(answerId);
    }

}
