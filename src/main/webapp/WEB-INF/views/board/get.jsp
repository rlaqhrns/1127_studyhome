<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp" %>
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"> 게시글 </h1>
        </div>
    </div>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">목록</div>
                <div class="panel-body">
                    <div class="form-group">
                        <label>Bno</label> <input class="form-control" name='bno' value='<c:out value="${board.bno }"/>' readonly="readonly">
                    </div>

                    <div class="form-group">
                        <label>Title</label> <input cl ass="form-control" name='title' value='<c:out value="${board.title }"/>' readonly="readonly">
                    </div>

                    <div class="form-group">
                        <label>Text area</label> <textarea class="form-control" rows="3" name='content' readonly ="readonly"><c:out value="${board.content }"/> </textarea>
                    </div>

                    <div class="form-group">
                        <label>Writer</label> <input class="form-control" name='writer' value='<c:out value="${board.writer }"/>' readonly="readonly">
                    </div>
                    <button data-oper='modify' class="btn btn-info" 
                        onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
                    <button data-oper='list' class="btn btn-primary"
                        onclick ="location.href='/board/list'">List</button>
                    <form id='operForm' action="/board/modify" id="operForm" method="get">
                        <input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
                        <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
                        <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
                        <input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
                        <input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
                    </form>
                </div>
        </div>
    </div>
</div>
<div class="row">
<div class="row col-lg-12">
    <!-- /.pannel -->
    <div class="panel panel-default">
       <div class="panel-heding">
           <i class="fa fa-comments fa-fw">
               Reply
           </i>
           </div>
           <!-- /.pannel-heaing -->
            <div class="panel-heading">
               <i class="fa fa-comments fa-fw"></i> Reply
               <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">
                   New Reply
               </button>
               </div>
           <div class="panel-body">
               <ul class="chat">
                   <li class="left clearfix" data-rno="12">
                       <div>
                           <div class="header">
                           <strong class="primary-font">user00</strong>
                           <small class="pull-right text-muted">
                               2018-01-01 13:13
                           </small>
                           </div>
                           <p>Good job!</p>
                       </div>
                   </li>
                   <!-- end reply -->
               </ul>
               <!-- /.end ul -->
           </div>
           <!-- /.pannel .chat-panel -->
           <div class="panel-footer">
               
           </div>
       </div>
    </div>
</div>

                <!-- modal 추가 -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> <!-- x 표시임 &;요게 -->
                        <h4 class="modal-title" id="myModalLabel">Modal title</h4>  
                      </div>
                      <div class="modal-body">
                          <div class="form-group">
                              <label>Reply</label>
                              <input class="form-control" name="reply" value="NewReply!">
                          </div>
                          <div class="form-group">
                              <label>Replyer</label>
                              <input class="form-control" name="replyer" value="replyer">
                          </div>
                          <div class="form-group">
                              <label>Reply Date</label>
                              <input class="form-control" name="replyDate" >
                          </div>
                      </div>
                      <div class="modal-footer">
                        <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
                        <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
                        <button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button id="modalRegisterBtn" type="button" class="btn btn-default" data-dismiss="modal">Register</button>
                      </div>
                    </div>
                    <!-- modal-content -->
                  </div>
                  <!-- modal dialog -->
                </div>
                <!-- modal -->
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">
//onclick="location.href='../board/list'"
//
  $(document).ready(function(){
	  console.log(replyService); //reply.js 의 return이 보여짐
    	console.log("=================="); //IIFE에 의해 즉시 호출되고 실행된결과
    	console.log("JS TEST");
    	var bnoValue = '<c:out value="${board.bno}"/>';
    	var replyUL = $(".chat");
    	
    	showList(1);
      
        var modal = $(".modal"); //jquery 변수 및 객체
        var modalInputReply = modal.find("input[name='reply']");
        var modalInputReplyer = modal.find("input[name='replyer']");
        var modalInputReplyDate = modal.find("input[name='replyDate']");
    	
        var modalModBtn = $("#modalModBtn");
        var modalRemoveBtn = $("#modalRemoveBtn");
        var modalRegisterBtn = $("#modalRegisterBtn");
      
        var pageNum = 1;
        var replyPageFooter = $(".panel-footer");
      
        function showReplyPage(replyCnt) {
            var endNum = Math.ceil(pageNum / 10.0) *10;
            var startNum = endNum - 9;
            
            var prev = startNum != 1;
            var next = false;
            
            if(endNum * 10 >= replyCnt) {
                endNum = Math.ceil(replyCnt/10.0);
            }
            
            if(endNum * 10<replyCnt) {
                next = true;
            }
            
            var str = "<ul class='pagination pull-right'>";
			if(prev){
				str += "<li class='page-item'><a class='page-link' href='"
						+ (startNum -1) + "'>Previous</a></li>";
			}
			
			for (var i = startNum; i <= endNum; i++) {
				var active = pageNum == i? "active" : "";
				str += "<li class='page-item " + active + " '><a class='page-link' href='"
						+ i + "'>" + i + "</a></li>";
			}
			
			if(next){
				str+= "<li class='page-item'><a class='page-link' href='"
						+ (endNum + 1) + "'>Next</a></li>";
			}
			str += "</ul></div>";
			
            
            str += "</ul></div>";
            
            console.log(str);
            
            replyPageFooter.html(str);
        }
      
        $("#addReplyBtn").on("click", function(e) { //신규 댓글 등록 버튼이 눌리면
            modal.find("input").val(""); //공백으로 초기화
            modalInputReplyDate.closest("div").hide(); //가장 가까운(closet) div태그를 찾아서 숨겨라
            modal.find("button[id != 'modalCloseBtn']").hide(); //close버튼을 제외하고 숨겨라
            modalRegisterBtn.show(); //등록버튼을 보여라
            $(".modal").modal("show");
       });
      
        replyPageFooter.on("click", "li a", function(e) {
            e.preventDefault();
            console.log("page click");
            
            var targetPageNum = $(this).attr("href");
            
            console.log("targetPageNum: " + targetPageNum);
            pageNum = targetPageNum;
            showList(pageNum);
        });
      
        //모달 modify 버튼이 눌리면
        modalModBtn.on("click", function(e){
            var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
            replyService.update(reply, function(result){
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            });
        });
        
        //모달 등록 버튼이 눌리면
        modalRegisterBtn.on("click", function(e){
            var reply = { //리터럴 객체를 저장
                reply: modalInputReply.val(),
                replyer: modalInputReplyer.val(),
                bno:bnoValue
            };
            replyService.add(reply, function(result){ //뒤에서 tag로 부터 jquery 를 이용하여 정보를 가져오고 
            	//그 정보를 reply 객체에 저장하고, 저장된 reply객체를 add함수에 전달
                alert(result);
                
                modal.find("input").val(""); //모달의 input 태그의 갑을 초기화(비우기)
                modal.modal("hide");//모달 숨기기, 보이기는 modal("show")
                
                //showList(1);//댓글 등록 후 위에서 정의한 showList 내부 함수 replyerService.getList() 호출되어 전체댓글 (데이터/)
            	showList(-1);
            });
        });
      
        modalRemoveBtn.on("click", function(e){
            var rno = modal.data("rno");
            replyService.remove(rno, function(result){
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            });
        });
        
        //댓글 조회 클릭 이벤트 처리시 부모(.chat/ul) 아래의 li 태그를 누르면 
        $(".chat").on ("click", "li", function(e){
        	var rno = $(this).data("rno");
        	console.log(rno);
        	
        	replyService.get(rno, function(reply){
        		modalInputReply.val(reply.reply);
        		modalInputReplyer.val(reply.replyer);
                modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
                modal.data("rno", reply.rno);
                
                modal.find("button[id != 'modalCloseBtn']").hide();
                modalModBtn.show();
                modalRemoveBtn.show();
                
                $(".modal").modal("show");
        	});
        });
      
    	function showList(page) {
    		replyService.getList({bno:bnoValue, page:page||1}, function(replyCnt, list){
    			
    			console.log("댓글 갯수 get.jsp에서 getList 호출함수내에서 댓글 개수" + replyCnt);
    			console.log("댓글 갯수 get.jsp에서 getList 호출함수내에서 댓글 목록" + list);
    			
    			//마지막 페이지일 경우 -1
    			if(page == -1){
    				pageNum = Math.ceil(replyCnt/10.0);
    				showList(pageNum);
    				return;
    			}
    			
    			var str = "";
    			if(list == null || list.length == 0){
    				//replyUL.html("");
    				return;
    			}
    			for(var i=0, len=list.length||0; i<len; i++) {
    				str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
    				str += " <div><div class='header'><strong class='primary-font'>["+list[i].rno+"] " + list[i].replyer+"</strong>";
    				str += " <small class ='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate)+"</small></div>";
    				str += "	<p>" + list[i].reply + "</p></div></li>";
    			}
    			replyUL.html(str);
                
                showReplyPage(replyCnt);
    		}); //end function, 첫번째 파라미터는 literal 객체, 두 번째 파라미터는 익명함수
    	}

    	
 /*    	replyService.getList(
    		{bno:bnoValue,page:1},
   			function(list){//정상 응답일때의 데이터를 받아서 그 결과만큼 반복하여 화면에 출력
    			//첫번쨰 파라미터의 bnoValue 값과 페이지 1페이지를 전달하여 url로
    			//만들어서 컨틀롤러에서 정상적이면 list에 데이터베이스에서 가져온 정보를 
    			//이 콜백이 호출될때 list에 담기고 그정보를 for문을 이용하여 출력함 
	    		for(var i=0; i<list.length;i++){
	    			console.log(list[i]);
	    	}
    	});
    	//reply add test 용
/*     	replyService.add({//data
    		reply:"JS TEST",
    		replyer:"tester",
    		bno:bnoValue
	    	},
	    	function(result){//콜백 
	    		alert("결과는 " +result);
	    	}
	    ); */
    	
/*     	//rno = 5번 댓글 삭제 테스트 
    	replyService.remove(5, function(count){
    		console.log(count);
    		if(count == "success") {
    			alert("REMOVED");
    		}
    	}, function(err) {
    		alert('ERROR...');
    	}); 
    	
    	
    	//return {name:"AAAA"} 의 내용을 console에 출력함
    	//rno 4번 댓글 수정 
    	replyService.update({
    		rno : 22,
    		bno : bnoValue, //bnoValues는 url을 통해서 받아서 처리함 get or update ? bno = 22
    		reply : "Modified Reply...."
    	}, function(result){
    		alert("수정 완료..");
    	});
    	
    	replyService.get(22, function(data) {
    		console.log(data);
    	});
    	 */
        var operForm = $("#operForm");
        
        //수정 버튼이 눌리면 from tag의 action을 /board/modify로 변경하여 전송
        $("button[data-oper='modify']").on("click", function(e){
            operForm.attr("action", "/board/modify").submit();
        });

        //목록 버튼이 눌리면 form tag의 action을 /board/list로 변경하여 전송
        $("button[data-oper='list']").on("click", function(e){ 
            operForm.find("#bno").remove(); //목록 전체를 보여주어야 하므로 bno제거ㅡ ㅜ
            operForm.attr("action", "/board/list").submit();
        })
        
        
        
    })
</script>
<%@include file="../include/footer.jsp"%>
</body> 
</html>               