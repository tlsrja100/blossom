/**
 * joinForm.jsp의 validation
 */
$(function(){
	$("#joinpage").validate({
		errorPlacement:function(error,element){
			$(element).closest("form").find("small[id='"+element.attr("id")+"']").append(error);
	},

		rules:{
			//required,
			//이메일 형식 
			//비밀번호는 문자,숫자,특수문자 사용해서 8~15자리 허용
			//confirm_password equalTo
			email:{
				required: true,
				validEmail : true,
				remote:{
					url:"checkEmail",
					type:"post",
					data:{
						email:function(){
							return $('#email').val();
						}
					}
				}
			},
			password:{
				required: true,
				validPwd : true
			},
			confirm_password:{
				required: true,
				validPwd : true,
				equalTo : "#password"
			},
			name:{
				required: true
			},
			addr:{
				required: true
			},
			phone:{
				required : true,
				validTel : true
			},
			birth:{
				required: true
			}
			
		},
		messages:{
			email:{
				required : "이메일은 필수 요소 입니다.",
				remote: "이미 사용중인 Email입니다."
			},
			password:{
				required: "비밀번호를 확인해 주세요.",
				minlength: "최소 8글자는 입력 해야합니다.",
				maxlength: "최대 15자리 까지 입력 가능합니다."
			},
			confirm_password:{
				required: "비밀번호를 확인해 주세요.",
				minlength: "최소 8글자는 입력 해야합니다.",
				maxlength: "최대 15자리 까지 입력 가능합니다.",
				equalTo : "이전 비밀번호와 다릅니다."
			},
			name:{
				required: "이름은 필수 요소 입니다.",
				minlength: "최소 2글자는 입력 해야합니다.",
				maxlength: "최대 4글자는 입력 해야합니다."
			},
			addr:{
				required: "주소는 필수 요소 입니다."
			},
			phone:{
				required: "전화번호는 필수 요소 입니다."
			},
			birth:{
				required: "생년월일은 필수 요소 입니다."
			}
			
		}
	});
});


$.validator.addMethod("validPwd",function(value){
	var regPwd= /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,15}$/;
	return regPwd.test(value);
},"패스워드는 숫자,영문자,특수문자의 조합으로 8~15자리까지만 입력 가능합니다.");

$.validator.addMethod("validEmail",function(value){
	var regEmail=/^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	return regEmail.test(value);
},"이메일을 확인해 주세요");

$.validator.addMethod("validTel",function(value){
	var regTel=/^\d{3}-\d{3,4}-\d{4}$/;
	return regTel.test(value);
},"전화번호를 확인해 주세요");