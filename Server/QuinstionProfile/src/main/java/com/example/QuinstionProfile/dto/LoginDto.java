package com.example.QuinstionProfile.dto;

public class LoginDto {

    private String email;
    private String password;
    private int socialMediaId = 3;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getSocialMediaId() {
        return socialMediaId;
    }

    public void setSocialMediaId(int socialMediaId) {
        this.socialMediaId = socialMediaId;
    }
}
