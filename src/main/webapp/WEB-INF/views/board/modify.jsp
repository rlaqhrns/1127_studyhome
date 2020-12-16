<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp" %>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">게시글 수정</h1>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">게시글 수정</div>
            <div class="panel-body">
                <form action="/board/modify" role="form" method="post">
                    <input type="hidden" name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
                    <input type="hidden" name='amount' value='<c:out value="${cri.amount}"/>'>
                    <input type="hidden" name='keyword' value='<c:out value="${cri.keyword}"/>'>
                    <input type="hidden" name='type' value='<c:out value="${cri.type}"/>'>
                    <div class="form-group">
                        <label>번호</label>
                        <input type="text" class="form-control" name="bno" value ='<c:out value="${board.bno}"/>' readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>제목</label>
                        <input type="text" class="form-control" name="title" value ='<c:out value="${board.title}"/>'>
                    </div>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control" rows="3" name="content"><c:out value="${board.content}"/></textarea>
                    </div>
                    <div class="form-group">
                        <label>작가</label>
                        <input type="text" class="form-control" name="writer" value ='<c:out value="${board.writer}"/>' readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>RegDate</label>
                        <input type="text" class="form-control" name="regDate" value ='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regDate}"/>' readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Update Date</label>
                        <input type="text" class="form-control" name="updateDate" value ='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>' readonly="readonly">
                    </div>
                    
                    <button type="submit" data-oper='modify' class="btn btn-default">수정</button>
                    <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
                    <button type="submit" data-oper='list' class="btn btn-info">목록</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        var formObj = $("form"); //form 태그 찾아서 jquery 객체화 함
        $('button').on("click", function(e) {
            e.preventDefault();

            var operation = $(this).data("oper");
            console.log(operation);

            if(operation === 'remove') {
                formObj.attr("action", "/board/remove");
            }else if(operation === 'list'){
                //move to list
                formObj.attr("action", "/board/list").attr("method", "get");
                var pageNumTag = $("input[name='pageNum']").clone();
                var amountTag = $("input[name='amount']").clone();
                var keywordTag = $("input[name='keyword']").clone();
                var typeTag = $("input[name='type']").clone();

                formObj.empty();
                formObj.append(pageNumTag);
                formObj.append(amountTag);
                formObj.append(keywordTag);
                formObj.append(typeTag);

                //self.location="/board/list";
                //return;
            }
            formObj.submit();
        });

    });


</script>
