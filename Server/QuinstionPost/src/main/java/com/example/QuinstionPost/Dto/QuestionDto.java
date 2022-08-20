package com.example.QuinstionPost.Dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class QuestionDto {
    private String description;
    private String codeEmbed;
    private String urlEmbed;
    private String accountId;
    private int numberOfUpvotes;
    private int numberOfDownvotes;
    private boolean alive;
    private String category;
    private String questionId; //internal
}
