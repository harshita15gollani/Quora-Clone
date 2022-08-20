package com.example.QuinstionPost.Dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccountDto {
    String accountId;
    String userName;
    String email;
    String description;
    String phoneNumber;
    int score;
    String password;
    String scoreBatch;
    String profileImage;
    String gender;
    String accountType;
    int noOfFollowers;
    int noOfFollowing;
}
