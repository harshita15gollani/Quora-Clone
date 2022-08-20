package com.example.QuinstionProfile.dto;

public class SignUpDto {

    private String name;
    private String email;
    private String gender;
    private String password;
    private String mobile;
    private int socialMediaId = 3;

    @Override
    public String toString() {
        return "SignUpDto{" +
                "name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", gender='" + gender + '\'' +
                ", password='" + password + '\'' +
                ", mobile='" + mobile + '\'' +
                ", socialMediaId=" + socialMediaId +
                '}';
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public int getSocialMediaId() {
        return socialMediaId;
    }

    public void setSocialMediaId(int socialMediaId) {
        this.socialMediaId = socialMediaId;
    }
}
