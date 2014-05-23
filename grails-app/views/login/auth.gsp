<html>
<head>
      <meta name="layout" content="bootstrap">
      <title><g:message code="springSecurity.login.title"/></title>
</head>

<body>
<div class="row-fluid" style="margin-top: 40px">
      <div class="span4"></div>
      <div class="span4">
            <g:if test="${flash.message}">
                  <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
            </g:if>
            <h3 class="text-center"> <g:message code="springSecurity.login.header"/> </h3>
            <form id='loginForm' class='form-horizontal' action='${postUrl}' method='POST' autocomplete='off'>
                  <fieldset class="form">
                        <div class="control-group fieldcontain ${hasErrors(bean: _DemoPageInstance, field: 'name', 'error')} ">
                              <label for='username' class="control-label"><g:message code="springSecurity.login.username.label"/>:</label>
                              <div class="controls">
                                    <input type='text' class='col-md-4' name='j_username' id='username'/>
                              </div>
                        </div>

                        <div class="control-group fieldcontain ${hasErrors(bean: _DemoPageInstance, field: 'name', 'error')} ">
                              <label for='password' class="control-label"><g:message code="springSecurity.login.password.label"/>:</label>
                              <div class="controls">
                                    <input type='password' class='col-md-4' name='j_password' id='password'/>
                              </div>
                        </div>

                        <div id="remember_me_holder" class="control-group fieldcontain">
                              <div class="controls">
                                    <label class="checkbox">
                                          <input type="checkbox" name="${rememberMeParameter}" value="${hasCookie}"><g:message code="springSecurity.login.remember.me.label"/>
                                    </label>
                              </div>
                        </div>
                  </fieldset>
                  <div class="controls">
                        <input type='submit' id="submit" class="btn btn-success" value='${message(code: "springSecurity.login.button")}'/>
                  </div>
            </form>
      </div>
      <div class="span4"></div>
</div>
<script type='text/javascript'>
      <!--
      (function() {
            document.forms['loginForm'].elements['j_username'].focus();
      })();
      // -->
</script>
</body>
</html>
