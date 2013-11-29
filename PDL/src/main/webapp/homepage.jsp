<%-- 
    Document   : homepage
    Created on : Nov 11, 2013, 2:25:25 PM
    Author     : wesley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="index_nl_NL" />

<!DOCTYPE html>
<html>
    <head>
        <!--Company Style-->
        <link rel="stylesheet" type="text/css" href="resources/css/homepage.css">
        <link rel="icon" href="resources/images/favicon.ico" type="image/x-icon"></link>
        <!-- Bootstrap-->
        <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="resources/bootstrap/dist/css/bootstrap.min.css">
        <script src="resources/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="resources/bootstrap/dist/js/alert.js"></script>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home - Info Support</title>
    </head>
    <body>
        <!--Start nav bar-->
        <nav class="navbar navbar-inverse" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="homepage.jsp"><img src="resources/images/Logo.png"></a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="margin-top:12px">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="homepage.jsp">Home</a></li>
                    <li><a href="/PDL/courses"><fmt:message key="navbar.course"/></a></li>
                     <c:if test="${loggedInIsAdmin == true}">
                        <li><a href="/PDL/management">Management</a></li>
                    </c:if>
                    <li><a href="/PDL/profile?id=${loggedInUserId}"><fmt:message key="navbar.profile"/></a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Settings <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="index.jsp">Logout</a></li>
                            <li class="divider"></li>
                            <li><a href="#">Help</a></li>
                            <li><a href="#">Report a Problem</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </nav>
        <!-- eof navbar-->
        <!-- Profile Information -->
        <div class="ProfileInformation">
            <table class="profileinformationtable123">
                <tr class="ProfilePictureHomepage"><td><input type="image" src="resources/images/users_icon.png"</td></tr>
                <tr class="ProfileNameHomepage"><td>${loggedInFirstname}&nbsp;${loggedInLastname}</td></tr>
                <c:if test="${loggedInIsAdmin == true}">
                    <tr class="ProfileRoleHomepage"><td>Admin</td></tr>
                </c:if>
                    <tr class="ChatIconHomepage"><td><input type="image" src="resources/images/ChatIconHomepage.png"></td></tr>
            </table>
        </div>    
        <!-- Activity Feed -->
        <div class="ActivityFeed">
        <table class="table table-hover table-bordered" end="5">
            <tr>
                <td colspan="4" class="TableHeader"><fmt:message key="activity.feed"/></th>
            </tr>
            <tr>
                <td class="Date"><fmt:message key="activity.date"/></td>
                <td><fmt:message key="activity.title"/></td>
                <td colspan="2"><fmt:message key="activity.message"/></td>
            </tr>
            <c:forEach var="tempActivity" items="${activityList}">           
            <tr>
                <td>${tempActivity.sent}</td>
                <td>${tempActivity.title}</td>
                <td class="Message">${tempActivity.message}</td>
                <td class="gotoMessage">
                    <input type="image" src="resources/images/gotoMessage.png" href="PDL/activity/message?id=${tempActivity.activityId}';">
                </td>
            </tr>
          </c:forEach>
        </table>
        </div>
        <!-- News Feed -->
        <div class="NewsFeed">
        <table class="table table-hover table-bordered" end="5">
            <tr>
                <td colspan="4" class="TableHeader"><fmt:message key="news.feed"/></th>
            </tr>
            <tr>
                <td class="Date"><fmt:message key="news.date"/></td>
                <td><fmt:message key="news.title"/></td>
                <td colspan="2"><fmt:message key="activity.message"/></td>
            </tr>
            <c:forEach var="tempActivity" items="${activityList}">           
            <tr>
                <td>${tempActivity.sent}</td>
                <td>${tempActivity.title}</td>
                <td class="Message">${tempActivity.message}</td>
                <td class="gotoMessage">
                    <input type="image" src="resources/images/gotoMessage.png" href="PDL/activity/message?id=${tempActivity.activityId}';">
                </td>
            </tr>
          </c:forEach>
        </table>
        </div>



    </body>
</html>