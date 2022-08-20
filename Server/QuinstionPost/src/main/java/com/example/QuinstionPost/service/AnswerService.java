package com.example.QuinstionPost.service;

import com.example.QuinstionPost.Dto.AnswerDto;
import com.example.QuinstionPost.Dto.QuestionDto;
import com.example.QuinstionPost.entity.Answer;
import com.example.QuinstionPost.entity.Question;

import java.util.List;

public interface AnswerService {
    AnswerDto addAnswer (AnswerDto answerDto, String accountId);
    List<AnswerDto> findByQuestionId(String questionId);
    void upVote(String questionId);
    void downVote(String questionId);

}
