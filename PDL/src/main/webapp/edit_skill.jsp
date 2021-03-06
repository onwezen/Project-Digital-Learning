<!--
@author Shahin Mokhtar
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="index" />
<html  lang="${language}">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap-->
        <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../resources/bootstrap/dist/css/bootstrap.min.css">
        <script src="../resources/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="../resources/bootstrap/dist/js/alert.js"></script>
        <!-- Company Style -->
        <link rel="Shortcut Icon" href="../resources/images/favicon.ico" type="image/x-icon">
        <link rel="Icon" href="../resources/images/favicon.ico" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="../resources/css/editmode.css">

        <title><c:if test="${isUpdate == true}"><fmt:message key="edit.popup.edit"/><fmt:message key="skill.skill"/> - Info Support</c:if>
            <c:if test="${isUpdate == false}"><fmt:message key="edit.popup.create"/><fmt:message key="skill.skill"/> - Info Support</c:if></title>
        <style type="text/css">
            textarea {
            }
            textarea {
                min-width: 350px; 
                min-height: 100px;
                max-width: 300px; 
                max-height: 300px;
            }
        </style>
    </head>
    <body onload="validateForm()">
        <div class="header">
            <h1>
                <c:if test="${isUpdate == true}"><fmt:message key="edit.popup.edit"/> <fmt:message key="skill.skill"/></c:if>
                <c:if test="${isUpdate == false}"><fmt:message key="edit.popup.create"/> <fmt:message key="skill.skill"/></c:if>
            </h1>
        </div>
        <c:choose>
            <c:when test="${empty skillId}">
                <!-- skill id = empty, new skill -->
                <form id="newSkill" action="new" method="post">
                </c:when>
                <c:otherwise>
                    <!-- else edit skill -->
                    <form id="editSkill" action="edit" method="post">
                    </c:otherwise>
                </c:choose>

                <!-- Bootstrap alerts -->
                <c:if test="${skillCreated == true}">
                    <div class="alert alert-success" style="margin-left:20px;margin-right:20px">
                        <a class="close" data-dismiss="alert">×</a>
                        <strong><fmt:message key="popup.done"/></strong> <fmt:message key="skill.edit.popup.new"/>
                    </div>
                </c:if>
                <c:if test="${skillUpdated == true}">
                    <div class="alert alert-success" style="margin-left:20px;margin-right:20px">
                        <a class="close" data-dismiss="alert">×</a>
                        <strong><fmt:message key="popup.done"/></strong> <fmt:message key="skill.edit.popup.update"/>
                    </div>
                </c:if>
                <c:if test="${errors != null}">
                    <script>
                        //concat the errors in a var
                        var errors = '<strong>Oh snap! </strong>';

                        <c:forEach var="error" items="${errors}" varStatus="count">
                        errors += '${error}';
                        </c:forEach>
                    </script>
                    <div class="alert alert-danger" style="margin-left:20px;margin-right:20px">
                        <a class="close" data-dismiss="alert">×</a>
                        <script>
                            document.write(errors);
                        </script>
                    </div>
                </c:if>
                <div id="validationAlert" style="margin-left:20px;margin-right:20px"></div>
                <!-- End of Bootstrap alerts -->

                <div id="form_container">
                    <div class="leftContainer">

                        <input type="hidden" name="skillId" id="skillId" value="${skillId}">

                        <div class="form-group" id="formGroupName" style="width:100%">
                            <label for="name"><fmt:message key="skill.name"/></label>
                            <input type="text" class="form-control" id="name" name="name" onchange="validateForm()" value="${name}">
                        </div>
                        
<!--                        <div class="form-group" id="" style="width:100%">
                            <label for="from"></label>
                            <select id="level" name="level">
                                <option value="${level}">${level}</option>
                                <option value="beginner">beginner</option>
                                <option value="intermediate">intermediate</option>
                                <option value="advanced">advanced</option>
                            </select>
                        </div>-->

                    </div>

                    <div class="rightContainer">

                    </div>
            </form>
        </div>
        <script>
            //initialize the form with variables if available
            document.getElementById('skillId').value = '${skillId}';
            document.getElementById('name').value = '${name}';
//            document.getElementById('level').value = '${level}';

            //close window
            function closeWindow() {
                console.log('canceling');
                $('#myModal').modal('show')
            }

            //function to refresh the parent window to reflect the updated data in the grid
            var isModified = false; // true when the form was submitted
            window.onunload = function() {
                if (isModified){ // only on save/edit
                    window.opener.location.reload();
                }
            };

            //set input color for validations
            function setValidated(id, isValidated) {
                if (isValidated) {
                    document.getElementById(id).className = 'form-group has-success';
                }
                else {
                    document.getElementById(id).className = 'form-group has-error';
                }
            }
            //use the same validations that are used on the server side
            function validateForm() {
                var regexRegular = '^[a-zA-Z0-9_ ]{1,25}$';
                var regexDesc = '^[a-zA-Z0-9_ ]{1,300}$';

                errors = "";
                
                //name
                var name = document.getElementById('name').value;
                if (!name || !name.match(regexRegular)) {
                    setValidated('formGroupName', false);
                    errors += 'Name must be 1-25 characters in size';
                }
                else {
                    setValidated('formGroupName', true);
                }
                
                //return true if there are errors
                if (errors) {
                    return true;
                }
                else {
                    return false;
                }
            }
            //save button press
            function saveForm() {
                if (validateForm()) {
                    document.getElementById('validationAlert').innerHTML = '<div class="alert alert-danger"><a class="close" data-dismiss="alert">×</a><strong>Oh snap!</strong> ' + errors + '</div>';
                }
                else {
                    isModified = true; // set true so we have to refresh the parent when closing
                    document.getElementById('validationAlert').innerHTML = '';
                    //check to see which form we need to submit (edit or new)
                    if (!document.getElementById('skillId').value) {
                        document.getElementById('newSkill').submit();
                    }
                    else {
                        document.getElementById('editSkill').submit();
                    }
                }
            }
        </script>
        <hr style="width:100%;margin-top:370px"/>
        <div style="float:right;margin-right:20px;margin-top:-10px;margin-bottom:10px">

            <button type="button" class="btn btn-default" onclick="closeWindow()"><fmt:message key="edit.popup.cancel"/></button>
            <button type="button" class="btn btn-primary" onclick="saveForm()"><fmt:message key="edit.popup.save"/></button>
        </div>
        <!-- Modal Dialog for Canceling -->
        <div class="modal fade" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><fmt:message key="edit.popup.unsaved"/></h4>
                    </div>
                    <div class="modal-body">
                        <p><fmt:message key="edit.popup.confirmation.message"/></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="edit.popup.continue"/></button>
                        <button type="button" class="btn btn-primary" onclick="window.close()"><fmt:message key="edit.popup.yes"/></button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
</body>
</html>