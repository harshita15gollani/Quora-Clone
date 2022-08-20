package com.example.QuinstionProfile.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class AccountDto {
    String id; //internal
    String userName;
    String email;
    String description;
    String phoneNumber;
    int score; ////internal
    String password;
    String scoreBatch; //internal
    String profileImage;
    String gender;
    String accountType;
    int noOfFollowers; //internal
    int noOfFollowing; //internal
    List<ViewMiniProfileDto> followers;
    List<ViewMiniProfileDto> following;
}
