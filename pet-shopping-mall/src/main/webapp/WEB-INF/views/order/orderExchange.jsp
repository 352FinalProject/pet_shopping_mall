<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <style>
        .container {
            margin: 0 auto;
            max-width: 1200px;
        }

        .sub_title {
            font-size: 32px;
            font-weight: bold;
            text-align: center;
            line-height: 120px;
        }

        .sub_title2 {
            font-size: 28px;
            font-weight: bold;
            text-align: center;
            line-height: 80px;
        }

        .exchange {
            max-width: 400px;
            margin: 80px auto;
        }

        .chk {
            font-size: 18px;
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        .chk input {
            border: 1px solid #ccc;

        }

        .chk label {
            margin-left: 5px;
            color: #555;
            font-weight: bold;
        }

        #select {
            position: relative;
            outline: none;
            display: block;
            width: 100%;
            margin: 30px auto;
            font-size: 18px;
            color: #333;
            height: 50px;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            padding-right: 50px;
            padding-left: 10px;
            background: url('./img/arrow-down.png') no-repeat 97% 50%/15px auto;
            border: 1px solid #999;
        }

        select option[value=""] {
            display: none;
        }

        #reason {
            border: 1px solid #999;
            resize: none;
            width: 100%;
            height: 250px;
            outline: none;
            padding: 10px;
            font-size: 20px;
            font-family: 'Raleway', sans-serif;
        }

        .con1 {
            width: 100%;
            border-bottom: 1px solid #ccc;
            margin-bottom: 50px;
        }

        .btn {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 50px;
        }

        .btn1 {
            width: 45%;
            text-align: center;
            background-color: #ccc;
            color: #fff;
            font-size: 24px;
            border: 0;
            border-radius: 18px;
            height: 50px;
        }

        .btn2 {
            width: 45%;
            text-align: center;
            background-color: #1776ad;
            color: #fff;
            font-size: 24px;
            border: 0;
            border-radius: 18px;
            height: 50px;
        }

        p {
            font-size: 18px;
            line-height: 5px;
            text-align: center;
            color: #ccc;

        }
    </style>
    <div id="wrap">

        <h3 class="sub_title">
            교환 / 반품
        </h3>

        <form>
            <div class="con1">

                <div class="exchange">
                    <div class="chk">

                        <div>
                            <input type="checkbox" name="chk" id="exchange" onclick="Check(this)"><label
                                for="exchange">교환</label>
                        </div>
                        <div>
                            <input type="checkbox" name="chk" id="return" onclick="Check(this)"><label
                                for="return">반품</label>
                        </div>
                    </div>
                    <select name="select" id="select">
                        <option value="" selected>교환 or 반품사유를 선택해주세요</option>
                        <option value="교환">교환</option>
                        <option value="반품">반품</option>
                    </select>
                    <textarea name="reason" id="reason" placeholder="상세 사유 입력 (선택사항)"></textarea>

                </div>
            </div>

            <div class="exchange">
                <h3 class="sub_title2">
                    택배 발송
                </h3>
                <div class="chk">

                    <div>
                        <input type="checkbox" name="chk2" id="kh" onclick="Check(this)"><label for="kh">kh택배</label>
                    </div>
                    <div>
                        <input type="checkbox" name="chk2" id="directly" onclick="Check(this)"><label
                            for="directly">직접발송</label>
                    </div>
                </div>
                <br>
                <p>국민 1111-11-11111 우리집동물친구</p>
                <br>
                <br>
               
                <p>교환 6,000원 | 반품 3,000원</p>
                <div class="btn">
                    <button class="btn1">돌아가기</button>
                    <button type="submit" class="btn2">신청하기</button>
                </div>
            </div>
        </form>

        </form>

    </div>


    </div>

    <script>
        function Check(chk) {
            var obj = document.getElementsByName("chk");
            for (var i = 0; i < obj.length; i++) {
                if (obj[i] != chk) {
                    obj[i].checked = false;
                }
            }
        }
        function Check2(chk) {
            var obj = document.getElementsByName("chk2");
            for (var i = 0; i < obj.length; i++) {
                if (obj[i] != chk) {
                    obj[i].checked = false;
                }
            }
        }


    </script>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />