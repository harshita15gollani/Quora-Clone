package com.example.QuinstionPost.Dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@ToString
public class ReturnAnswerCommentDto {
    String id;
    String questionId;
    String accountId;
    String answerDescription;
    int numberOfUpvotes;
    int numberOfDownvotes;
    Date dateModified;
    String codeEmbed;
    String urlEmbed;
    boolean accepted;

    List<TempCommentDto> nestedComment;

    public List<TempCommentDto> getNestedComment() {
        return nestedComment;
    }

    public void setNestedComment(List<TempCommentDto> nestedComment) {
        this.nestedComment = nestedComment;
    }
}
