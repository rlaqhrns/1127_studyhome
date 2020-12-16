<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp" %>



    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
              <div class="card-header py-3">
              	<h6 class="m-0 font-weight-bold text-primary">DataTables 예제</h6>
              <div class="panel-heading">Board List Page
                 <button id="regBtn" type="button" class="btn btn-xs pull-right" style="color: violet">Register New Board</button>
              </div>
            </div>
            
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>#번호</th>
                      <th>제목</th>
                      <th>내용</th>
                      <th>작성자</th>
                      <th>작성일</th>
                      <th>수정일</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>#번호</th>
                      <th>제목</th>
                      <th>내용</th>
                      <th>작성자</th>
                      <th>작성일</th>
                      <th>수정일</th>
                    </tr>
                  </tfoot>
                  <tbody>
                  <c:forEach items="${list}" var ="board">
                    <tr>
                      <td><c:out value="${board.bno}"></c:out></td>
                      <%-- <td><a href='/board/get?bno=<c:out value="${board.bno}"/>'>
                      <c:out value="${board.title}"></c:out></a></td> --%>
                      <td><a href='<c:out value="${board.bno}"/>' class="move">
                      <c:out value="${board.title}"/><b>[<c:out value="${board.replyCnt}"/>]</b>
                      </a></td>
                      <td><c:out value="${board.content}"></c:out></td>
                      <td><c:out value="${board.writer}"></c:out></td>
                      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}"/></td>
                      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>                
                   </c:forEach> 
                  </tbody>
                </table>
                <!-- End of Tables Example -->
          <div class="row">
            <div class="col-lg-12">
              <form action="/board/list" id="searchForm" method="get">
                <select name="type" id="">
                  <option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
                  <option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
                  <option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
                  <option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
                  <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
                  <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 or 작성자</option>
                  <option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목 or 내용 or 작성자</option>
                </select>
                <input type="text" name="keyword" value= '<c:out value="${pageMaker.cri.keyword}"/>' />
                <input type="hidden" name="pageNum" value= '<c:out value="${pageMaker.cri.pageNum}"/>'/>
                <input type="hidden" name="amount" value= '<c:out value="${pageMaker.cri.amount}"/>' />
                <input type="hidden" name="type" value= '<c:out value="${pageMaker.cri.type}"/>' />
                <button class="btn btn-default">검색</button>
              </form>
            </div>
          </div>
          <div class="row">
            <div class="col-lg-12">
              <form action="/board/list" id ="actionForm" method="get">
                <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                <input type="hidden" name="type" value="${pageMaker.cri.type}">
                <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
              </form>
            </div>
          </div>
            
                <div class="pull-right">
                  <ul class="pagination">
                    <c:if test = "${pageMaker.prev}">
                      <li class="paginate_button previous"><a href="${pageMaker.startPage -1}">Previous</a> 
                      </li>
                    </c:if>
                    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                      <li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
                      <a href="${num}">${num}</a>
                      </li>
                    </c:forEach>

                    <c:if test="${pageMaker.next}">
                      <li class="paginate_button next">
                      <a href="${pageMaker.endPage +1}">Next</a></li>
                    </c:if>
                  </ul>
                </>

                <!-- modal 추가 -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> <!-- x 표시임 &;요게 -->    
                      </div>
                      <div class="modal-body">처리가 완료되었습니다</div>
                      <div class="modal-footer">
                        <button class="btn btn-default" type="button" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save Changes</button>
                      </div>
                    </div>
                    <!-- modal-content -->
                  </div>
                  <!-- modal dialog -->
                </div>
                <!-- modal -->

          <!-- Scroll to Top Button-->
  				<a class="scroll-to-top rounded" href="#page-top">
   					<i class="fas fa-angle-up"></i>
  				</a>
  				
  				<script type="text/javascript">
		            $(document).ready(function() { //257pg history로 수정 
		            	
		
		              var result = '<c:out value="${result}"/>'; //246pg
		              checkModal(result);

                  history.replaceState({}, null, null); //추가
                  //history entry와 관련된 것, 제목, url 
                  //history가 스택에 쌓이는 상태는 모달창을 보여주지 않기 위해 추가함 
		              function checkModal(result) {
                    if(result==='' || history.state) { //수정, result에 값이 없거나
                    //history의 state가 스택(LIFO(last input Frist output)에 있으면 true가 된다)
		                  return;
		                }
		
		                if(parseInt(result) > 0) {
		                  $(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
		                }
		
		                $("#myModal").modal("show");
                  }
                  
                  $("#regBtn").on("click", function() {
                    self.location = "/board/register";
                  });

                  var actionForm = $("#actionForm");
                  $(".paginate_button a").on("click", function(e) {
                    e.preventDefault();
                    console.log('click');
                    actionForm.find("input[name='pageNum']").val($(this).attr("href"));
                  //id가 actionForm(Form, input type = hidden)
                  //class가 paginate_button 하위 요소의 a 태그 눌리면, a의 속성값이 href
                  //찾고 그 값을(url) 가져다가 actionForm 아래에 있는 input type의 name = pageNum
                  //찾은 url을 저장 
                  
                  });

                  $(".move").on("click", function(e){ 
                	  e.preventDefault();
                    actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
                    actionForm.attr("action", "/board/get");
                    actionForm.submit();
                 		 });
                  
              });
              
              var searchForm = $("#searchForm");
              $("#searchForm button").on("click", function(e) {

                if(!searchForm.find("option:selected").val()) {
                  alert("검색종류를 선택하세요");
                  return false;
                }

                if(!searchForm.find("input[name='keyword']").val()) {
                  alert("키워드를 입력하세요");
                  return false;
                }

                searchForm.find("input[name='pageNum']").val("1");
                e.preventDefault();

                searchForm.submit();
                

              })
		            
		            
          </script>
                
              </div>
            </div>
  

<%@ include file="../include/footer.jsp" %>
  