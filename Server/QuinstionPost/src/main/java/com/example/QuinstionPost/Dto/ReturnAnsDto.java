package com.example.QuinstionPost.Dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class ReturnAnsDto {
    String questionId;
    String accountId;
    String answerId;
    String AnswerDescription;
    int numberOfUpvotes;
    int numberOfDownvotes;
    String codeEmbed;
    String urlEmbed;
    boolean accepted;
    String profileImage;
    String userName;

    List<ReturnCommentDto> commentsLevel;

    public void setCommentsLevel(List<ReturnCommentDto> commentsLevel0) {
        this.commentsLevel = commentsLevel0;
    }

    public List<ReturnCommentDto> getCommentsLevel() {
        return commentsLevel;
    }
}
