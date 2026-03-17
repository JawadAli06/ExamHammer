<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/student/student_header.jsp" %>

<div class="card border-0 shadow-sm rounded-4">
    <div class="card-body">
        <h3 class="mb-4">Start Exam - ${exam.examName}</h3>

        <form action="${pageContext.request.contextPath}/student/submitExam" method="post">
            <input type="hidden" name="examId" value="${exam.examId}" />

            <c:forEach var="item" items="${examQuestions}" varStatus="status">
                <c:set var="q" value="${item.question}" />

                <div class="mb-4 p-3 border rounded">
                    <p class="fw-bold">
                        Q${status.count}. ${q.questionText}
                    </p>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="answer_${q.questionId}" value="A" id="q${q.questionId}A">
                        <label class="form-check-label" for="q${q.questionId}A">
                            ${q.optionA}
                        </label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="answer_${q.questionId}" value="B" id="q${q.questionId}B">
                        <label class="form-check-label" for="q${q.questionId}B">
                            ${q.optionB}
                        </label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="answer_${q.questionId}" value="C" id="q${q.questionId}C">
                        <label class="form-check-label" for="q${q.questionId}C">
                            ${q.optionC}
                        </label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="answer_${q.questionId}" value="D" id="q${q.questionId}D">
                        <label class="form-check-label" for="q${q.questionId}D">
                            ${q.optionD}
                        </label>
                    </div>
                </div>
            </c:forEach>

            <button type="submit" class="btn btn-primary">Submit Exam</button>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/views/student/student_footer.jsp" %>