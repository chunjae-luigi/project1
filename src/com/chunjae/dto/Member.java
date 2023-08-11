// Source code is decompiled from a .class file using FernFlower decompiler.
package com.chunjae.dto;

public class Member {
  private String id;
  private String pw;
  private String name;
  private String email;
  private String tel;
  private String regdate;
  private int point;

  public Member() {
  }

  public Member(String id, String pw, String name, String email, String tel, String regdate, int point) {
    this.id = id;
    this.pw = pw;
    this.name = name;
    this.email = email;
    this.tel = tel;
    this.regdate = regdate;
    this.point = point;
  }

  public String getId() {
    return this.id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getPw() {
    return this.pw;
  }

  public void setPw(String pw) {
    this.pw = pw;
  }

  public String getName() {
    return this.name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getEmail() {
    return this.email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getTel() {
    return this.tel;
  }

  public void setTel(String tel) {
    this.tel = tel;
  }

  public String getRegdate() {
    return this.regdate;
  }

  public void setRegdate(String regdate) {
    this.regdate = regdate;
  }

  public int getPoint() {
    return this.point;
  }

  public void setPoint(int point) {
    this.point = point;
  }

  public String toString() {
    return "Member{id='" + this.id + "', pw='" + this.pw + "', name='" + this.name + "', email='" + this.email + "', tel='" + this.tel + "', regdate='" + this.regdate + "', point=" + this.point + "}";
  }
}