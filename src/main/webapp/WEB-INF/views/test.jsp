<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	var replyService = {"a" : function(i){console.log(i); return i+10;},
						"b" : function(i,j){console.log(i+j); return i+j*20}}
	var replyServiceIIFE = (function(){
		return  {"a" : function(i){console.log(i); return i+10;},
			"b" : function(i,j){console.log(i+j); return i+j*20}}
	})();
	var replyServiceRealIIFE = (function(){
		let add = function(i){console.log(i); return i+10;};
		let getList = function(i,j){console.log(i+j); return i+j*20;};
		let remove = function(i,j){console.log(i+j); return i+j*20;};
		let result = [];
		let arrayList =function(re){
			for(let i = 0; i<re.length;i++){
				console.log(re[i]);
				result.push(i);
				
			}
			return result;
		};
		return {
			a : add,
			b : getList,
			c : remove,
			d : arrayList
		};
		
		
	})();
	let array = [1,2,3,4,5];
	var result = replyService.a(7);
	console.log("a의 값을 가지고 호출되는 함수의 결과는 " + result);
	result = replyService.b(3,4);
	console.log("b keys에 해당하는 값 " + result);
	console.log("replyServiceIIFE" + replyServiceIIFE);
	result = replyServiceRealIIFE.d(array);
	console.log("배열 출력 function() " + result);
	
</script>
</head>
<body>안녕 테스트페이지입니다.

</body>
</html>