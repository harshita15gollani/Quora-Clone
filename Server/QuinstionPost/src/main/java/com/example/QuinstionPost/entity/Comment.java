package com.example.QuinstionPost.entity;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
@Setter
@Getter
@ToString
public class Comment {
    @Id
    String id;
    String accountId;
    String answerId;
    String parentId;
    int level;
    String commentText;
    String codeEmbed;
    String urlEmbed;

    // todo : duplication of user name & profile image at each Answer level is not all allowed.. if user changes the name, you have to update across all the objects
    String userName;
    String profileImage;
}
