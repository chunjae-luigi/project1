<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>그로우앤조이</title>
    <%@ include file="head.jsp" %>
    <link rel="stylesheet" href="<%=headPath%>/css/main.css">
</head>
<body>
<div class="wrap">
    <header class="hd" id="hd">
        <%@ include file="header.jsp" %>
    </header>
    <div class="contents" id="contents">
        <figure class="vs">
            <ul class="img_box">
                <li class="item1 active">
                    <input type="radio" name="vs_ra" id="vs_ra1" class="vs_ra" checked>
                    <div class="bg_box"></div>
                    <h2 class="vs_tit">교육에 대한 끊임없는 도전<br>
                        <strong>행복한 내일을 함께 합니다</strong></h2>
                </li>
                <li class="item2">
                    <input type="radio" name="vs_ra" id="vs_ra2" class="vs_ra">
                    <div class="bg_box"></div>
                    <h2 class="vs_tit">“나눔의 힘! 실천의 힘!”<br>
                        <strong>작은 따뜻함으로 세상을 <br>바꿉니다</strong>
                    </h2>
                </li>
            </ul>
            <ul class="btn_box">
                <li class="item1 active"><label for="vs_ra1" class="vs_btn"></label></li>
                <li class="item2"><label for="vs_ra2" class="vs_btn"></label></li>
            </ul>
            <button type="button" class="play_btn"></button>
        </figure>
        <script>
            $(function(){
                $(".btn_box li .vs_btn").click(function(){
                    var par = $(this).parents("li").index();
                    $(".img_box li").removeClass("active");
                    $(".img_box li").eq(par).addClass("active");
                    $(".btn_box li").removeClass("active");
                    $(".btn_box li").eq(par).addClass("active");
                });
                var sw = 1;
                var int1 = setInterval(function(){
                    if(sw==1){
                        autoplay(1);
                        sw = 0;
                    } else {
                        autoplay(0);
                        sw = 1;
                    }
                }, 3500);

                function autoplay(n){
                    $(".img_box li").removeClass("active");
                    $(".img_box li").eq(n).addClass("active");
                    $(".btn_box li").removeClass("active");
                    $(".btn_box li").eq(n).addClass("active");
                }

                $(".play_btn").click(function(){
                    if($(this).hasClass("active")){
                        $(this).removeClass("active");
                        sw = 1;
                        int1 = setInterval(function(){
                            if(sw==1){
                                autoplay(1);
                                sw = 0;
                            } else {
                                autoplay(0);
                                sw = 1;
                            }
                        }, 3500);
                    } else {
                        $(this).addClass("active");
                        sw = 0;
                        clearInterval(int1);
                    }
                });
            });
        </script>
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">Grow & Joy</h2>
                <ul class="pic_lst">
                    <li class="item1">
                        <a href="">
                            <p class="pic_com">교육 관련 도서 정보</p>
                            <h3 class="pic_tit">도서</h3>
                            <span class="pic_arrow"></span>
                        </a>
                    </li>
                    <li class="item2">
                        <a href="">
                            <p class="pic_com">공지사항</p>
                            <h3 class="pic_tit">공지사항</h3>
                            <span class="pic_arrow"></span>
                        </a>
                    </li>
                    <li class="item3">
                        <a href="">
                            <p class="pic_com">자유게시판</p>
                            <h3 class="pic_tit">자유게시판</h3>
                            <span class="pic_arrow"></span>
                        </a>
                    </li>
                    <li class="item4">
                        <a href="">
                            <p class="pic_com">QnA</p>
                            <h3 class="pic_tit">QnA</h3>
                            <span class="pic_arrow"></span>
                        </a>
                    </li>
                </ul>
            </div>
        </section>
        <section class="page" id="page2">
            <div class="page_wrap">
                <h2 class="page_tit">이벤트</h2>
                <p class="page_com">그로우앤조이에서 진행된 이벤트를 소개합니다.</p>
                <div class="sl-btn-box">
                    <button type="button" class="btn next">&gt;</button>
                    <button type="button" class="btn prev">&lt;</button>
                </div>
                <div class="slide_box">
                    <ul class="card_lst">
                        <li class="item1">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2썸네일제목2썸네일제목2 썸네일제목2 </p>
                                <div class="ico_box"><span class="ico item1"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                        <li class="item2">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2썸네일제목2썸네일제목2 썸네일제목2 </p>
                                <div class="ico_box"><span class="ico item1"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                        <li class="item3">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목3</p>
                                <div class="ico_box"><span class="ico item1"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                        <li class="item4">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목4</p>
                                <div class="ico_box"><span class="ico item2"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                        <li class="item5">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목5</p>
                                <div class="ico_box"><span class="ico item1"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                        <li class="item6">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목6</p>
                                <div class="ico_box"><span class="ico item2"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                        <li class="item7">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목7</p>
                                <div class="ico_box"><span class="ico item1"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </section>
        <script>
            $(function(){
                $(".sl-btn-box .btn.next").click(function(){
                    var ln = parseInt($(".card_lst").css("margin-left"));
                    if(ln>-1110) {
                        var mv = ln - 370;
                        $(".card_lst").not(":animated").animate({"margin-left":mv+"px"});
                    }
                });
                $(".sl-btn-box .btn.prev").click(function(){
                    var ln = parseInt($(".card_lst").css("margin-left"));
                    if(ln<0){
                        var mv = ln + 370;
                        $(".card_lst").not(":animated").animate({"margin-left":mv+"px"});
                    }
                });
            });
        </script>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="footer.jsp" %>
    </footer>
</div>
</body>
</html>