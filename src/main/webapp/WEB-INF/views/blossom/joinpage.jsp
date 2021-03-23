<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../include/header.jsp" %>
<link rel="stylesheet" href="/resources/css/join.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
<script src="/resources/js/joinform.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br />
	<br />
	<div class="form-group">
		<label class="join">회원 가입</label>
	</div>
	<div class="form-group">
		<form action="/blossom/joinpage" method="post" id="joinpage">
			<div class="form-group">
				<label for="email">이메일</label>
				<input type="text" class="form-control" id="email" name="email" placeholder="E-mail"/>
				<small id="email" class="text-info"></small>
			</div>
			
			<div class="form-group">
				<label for="password">비밀번호</label>
				<input type="password" class="form-control" id="password" name="password" placeholder="Password"/>
				<small id="password" class="text-info"></small>
			</div>
			
			<div class="form-group">
				<label for="password">비밀번호 확인</label>
				<input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Confirm Password"/>
				<small id="confirm_password" class="text-info"></small>
			</div>
			
			<div class="form-group">
				<label for="name">이름</label>
				<input type="text" class="form-control" id="name" name="name" placeholder="Name"/>
				<small id="name" class="text-info"></small>
			</div>
			
			<div class="form-group">
				<label class="birth">생년월일</label>
				<input type="text" class="form-control" id="birth" name="birth" placeholder="YYMMDD"/>
				<small id="birth" class="text-info"></small>
			</div>
			
			<div class="form-group" style="height:40px;">
				<label class="gender">성별  : </label>
				<input type="radio" style="margin-left:10px;" id="gender" name="gender" value="male" checked="checked"> 남성
				<input type="radio" style="margin-left:10px;" name="gender" value="female"> 여성
			</div>
			
			<div class="form-group"> 
				<label class="phone">휴대전화('-'제외하고 입력해주세요)</label>
				<input type="text" class="form-control" id="phone" name="phone" maxlength="13"> 
				<small id="phone" class="text-info"></small>
			</div>
			
			<div class="form-group">
				<label class="addr">주소</label>
				<br />
				<input type="text" class="form-control" style="width: 40%; margin-bottom:5px; display: inline;" placeholder="우편번호" name="addr1" id="addr1" readonly="readonly"/>
				<button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i>우편번호 찾기</button>
	  			<input type="text" class="form-control" style=" margin-bottom:5px;" placeholder="도로명 주소" name="addr2" id="addr2" readonly="readonly" />
				<input type="text" class="form-control" style=" margin-bottom:5px;" placeholder="상세주소"  name="addr3" id="addr3"/>
				<small id="addr" class="text-info"></small>
			</div>
			
			<div class="form-group text-center" style="margin-top:100px;">
				<button type="submit" class="joinbtn">회원가입</button>
			</div>
		</form>
	</div>
</body>
<script>
/* 하이픈 자동생성 */
var autoHypenPhone = function(str){
	str = str.replace(/[^0-9]/g, "");
	var tmp = "";
	if(str.length < 4) {
		return str;
	} else if(str.length < 7) {
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3);
		return tmp;
	} else if(str.length < 11) {
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 3);
		tmp += '-';
		tmp += str.substr(6);
		return tmp;
		return tmp;
	} else {
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 4);
		tmp += '-';
		tmp += str.substr(7);
		return tmp;
	}
	return str;
}

var phone = document.getElementById("phone");
phone.onkeyup = function(){
	console.log(this.value);
	this.value = autoHypenPhone(this.value);
}

/* 다음 주소 API */
function execPostCode() {
         new daum.Postcode({
             oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                console.log(data.zonecode);
                console.log(fullRoadAddr);
                
                
                $("[name=addr1]").val(data.zonecode);
                $("[name=addr2]").val(fullRoadAddr);
                
                /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
                document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
            }
         }).open();
     }


</script>
</html>