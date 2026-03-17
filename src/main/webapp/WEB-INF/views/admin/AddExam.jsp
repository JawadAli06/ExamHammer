<%@ include file="/WEB-INF/views/admin/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-3" style="max-width:550px;">

    <div class="card shadow-sm">
        <div class="card-body p-3">

            <h4 class="text-center mb-4">Add / Edit Exam</h4>

            <form action="${pageContext.request.contextPath}/admin/exams/save" method="post">

                <input type="hidden" name="examId" value="${exam.examId}" />

                <div class="mb-3">
                    <label class="form-label">Exam Name</label>
                    <input type="text" name="examName" class="form-control"
                           value="${exam.examName}" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Exam Type</label>
                    <select name="examType" class="form-control" required>
                        <option value="SCHOOL" ${exam.examType=='SCHOOL'?'selected':''}>SCHOOL</option>
                        <option value="COLLEGE" ${exam.examType=='COLLEGE'?'selected':''}>COLLEGE</option>
                        <option value="JOB" ${exam.examType=='JOB'?'selected':''}>JOB</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Subject</label>
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

                <div class="mb-3">
                    <label class="form-label">Difficulty</label>
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

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Total Questions</label>
                        <input type="number" name="totalQuestions" class="form-control"
                               value="${exam.totalQuestions}" required />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Total Marks</label>
                        <input type="number" name="totalMarks" class="form-control"
                               value="${exam.totalMarks}" required />
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Duration (Minutes)</label>
                    <input type="number" name="durationMinutes" class="form-control"
                           value="${exam.durationMinutes}" required />
                </div>

                <!-- Passing Score -->
                <div class="mb-3">
                    <label class="form-label">Passing Score</label>
                    <input type="number" name="passingScore" class="form-control"
                           value="${exam.passingScore}" min="0" />
                </div>

                <!-- Negative Marking -->
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" name="negativeMarking" value="true"
                           <c:if test="${exam.negativeMarking == true}">checked</c:if>>
                    <label class="form-check-label">Negative Marking</label>
                </div>

                <!-- Dates -->
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Start Date</label>
                        <input type="date" name="startDate" class="form-control"
                               value="${exam.startDate}" />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">End Date</label>
                        <input type="date" name="endDate" class="form-control"
                               value="${exam.endDate}" />
                    </div>
                </div>

                <div class="d-grid mt-3">
                    <button type="submit" class="btn btn-success">Save</button>
                </div>

            </form>

        </div>
    </div>

</div>

<%@ include file="/WEB-INF/views/admin/footer.jsp" %>