package com.example.QuinstionPost.Dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Setter
@Getter
@ToString
public class ReturnPostsDto {
    private String description;
    private String codeEmbed;
    private String urlEmbed;
    private String accountId;
    private int numberOfUpvotes;
    private int numberOfDownvotes;
    private boolean alive;
    String profileImage;
    String userName;
    private String questionId;
    private String category;
    List<ReturnAnsDto> answersList;

    public void setAnswersList(List<ReturnAnsDto> answersList) {
        this.answersList = answersList;
    }

    public List<ReturnAnsDto> getAnswersList() {
        return answersList;
    }
}
