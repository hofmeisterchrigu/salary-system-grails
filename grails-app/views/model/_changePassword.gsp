<r:require module="jquery-validation-ui" />
<div class="modal hide" id="changePasswordModel">
      <g:form controller="user" action="changePassword" class="form-horizontal" method="post" name="change_password" id='change_password'>
            <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">x</button>
                  <h3>Change Password</h3>
            </div>
            <div class="modal-body">
                  <div class="control-group required">
                        <label class="control-label" for="oldPassword">
                              Old Password
                              <span class="required-indicator">*</span>
                        </label>
                        <div class="controls">
                              <input type="password" name="oldPassword" id="oldPassword" placeholder="Old password">
                        </div>
                  </div>
                  <div class="control-group required">
                        <label class="control-label" for="newPassword">
                              New Password
                              <span class="required-indicator">*</span>
                        </label>
                        <div class="controls">
                              <input type="password" name="newPassword" id="newPassword" placeholder="New password">
                        </div>
                  </div><div class="control-group required">
                  <label class="control-label" for="repeatPassword">
                        Confirm Password
                        <span class="required-indicator">*</span>
                  </label>
                  <div class="controls">
                        <input type="password" name="repeatPassword" id="repeatPassword" placeholder="Repeat password">
                  </div>
            </div>
            </div>
            <div class="modal-footer">
                  <button type="submit" class="btn btn-primary">Change Password</button>
            </div>
      </g:form>
</div>
<script>
      $().ready(function() {
            var validation=$("#change_password").validate({
                  onkeyup: false,
                  errorClass: 'error',
                  errorElement: 'label',
                  validClass: 'valid',
                  onsubmit: true,
                  rules: {
                        oldPassword: "required",
                        newPassword:"required",
                        repeatPassword: {
                              required: true,
                              equalTo: "#newPassword"
                        }
                  },
                  messages: {
                        oldPassword: "Please enter your old password",
                        newPassword:  "Please provide a new password",
                        repeatPassword: {
                              required: "Please provide a repeat password",
                              equalTo: "Please enter the same password as above"
                        }
                  }, highlight: function (element) {
                        $(element).closest('.control-group')
                                .removeClass('success').addClass('error');
                  },
                  success: function (element) {
                        $(element).addClass('valid').closest('.control-group')
                                .removeClass('error');
                  }
            });
            $('#changePasswordModel').on('hidden', function(){
                  $.clearInput(this);
                  validation.resetForm();
            });
            $.clearInput = function (form) {
                  $(form).find('input[type=text], input[type=password], input[type=number], input[type=email], textarea').val('');
                  $(form).find('.control-group').removeClass('error');
            };
      });

</script>

