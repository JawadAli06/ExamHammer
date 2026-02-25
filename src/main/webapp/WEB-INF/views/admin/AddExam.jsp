<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h3>Add / Edit Exam</h3>
<hr>

<form action="${pageContext.request.contextPath}/admin/exams/save" method="post">

    <input type="hidden" name="examId" value="${exam.examId}" />

    <div class="form-group">
        <label>Exam Name</label>
        <input type="text" name="examName" class="form-control"
               value="${exam.examName}" required />
    </div>

    <div class="form-group">
        <label>Exam Type</label>
        <select name="examType" class="form-control" required>
            <option value="SCHOOL" ${exam.examType=='SCHOOL'?'selected':''}>SCHOOL</option>
            <option value="COLLEGE" ${exam.examType=='COLLEGE'?'selected':''}>COLLEGE</option>
            <option value="JOB" ${exam.examType=='JOB'?'selected':''}>JOB</option>
        </select>
    </div>

    <div class="form-group">
        <label>Subject</label>
        <select name="subjectId" class="form-control" required>
            <option value="">Select Subject</option>
            <c:forEach var="s" items="${subjects}">
                <option value="${s.subjectId}"
                    <c:if test="${exam.subject != null && exam.subject.subjectId == s.subjectId}">selected</c:if>>
                    ${s.subjectName}
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="form-group">
        <label>Difficulty</label>
        <select name="difficultyId" class="form-control" required>
            <option value="">Select Difficulty</option>
            <c:forEach var="d" items="${difficulties}">
                <option value="${d.difficultyId}"
                    <c:if test="${exam.difficulty != null && exam.difficulty.difficultyId == d.difficultyId}">selected</c:if>>
                    ${d.level}
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="form-group">
        <label>Total Questions</label>
        <input type="number" name="totalQuestions" class="form-control"
               value="${exam.totalQuestions}" required />
    </div>

    <div class="form-group">
        <label>Total Marks</label>
        <input type="number" name="totalMarks" class="form-control"
               value="${exam.totalMarks}" required />
    </div>

    <div class="form-group">
        <label>Duration (Minutes)</label>
        <input type="number" name="durationMinutes" class="form-control"
               value="${exam.durationMinutes}" required />
    </div>

    <button type="submit" class="btn btn-success mt-2">Save</button>
</form>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>