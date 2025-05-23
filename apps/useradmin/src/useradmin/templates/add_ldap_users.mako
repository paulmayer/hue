## Licensed to Cloudera, Inc. under one
## or more contributor license agreements.  See the NOTICE file
## distributed with this work for additional information
## regarding copyright ownership.  Cloudera, Inc. licenses this file
## to you under the Apache License, Version 2.0 (the
## "License"); you may not use this file except in compliance
## with the License.  You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
<%!
import sys
from desktop.views import commonheader, commonfooter
from desktop.lib.django_util import extract_field_data
if sys.version_info[0] > 2:
  from django.utils.translation import gettext as _
else:
  from django.utils.translation import ugettext as _
%>

<%namespace name="layout" file="layout.mako" />
%if not is_embeddable:
${ commonheader(_('Hue Users'), "useradmin", user, request) | n,unicode }
%endif

${ layout.menubar(section='users') }

<div id="addLdapUsersComponents" class="useradmin container-fluid">
  <div class="card card-small">
    <h1 class="card-heading simple">${_('Hue Users - Add/Sync LDAP user')}</h1>
    <br/>

    <form id="syncForm" action="${ url('useradmin:useradmin.views.add_ldap_users') }" method="POST" class="form form-horizontal" autocomplete="off">
      ${ csrf_token(request) | n,unicode }
      % if is_embeddable:
        <input type="hidden" value="true" name="is_embeddable" />
      % endif
      <fieldset>
        % for field in form.fields:
          % if form[field].is_hidden:
            ${ form[field] }
          % else:
            ${ layout.render_field(form[field]) }
          % endif
        % endfor
      </fieldset>
      <br/>
      <div class="form-actions">
        % if username:
          <input type="submit" class="btn btn-primary disable-feedback" value="${_('Update user')}"/>
        % else:
          <input type="submit" class="btn btn-primary disable-feedback" value="${_('Add/Sync user')}"/>
        % endif
        <a href="${ url('useradmin:useradmin.views.list_users') }" class="btn">${_('Cancel')}</a>
      </div>
    </form>
  </div>
</div>
<script src="${ static('desktop/js/add_ldap-inline.js') }" type="text/javascript"></script>

${layout.commons()}

%if not is_embeddable:
${ commonfooter(request, messages) | n,unicode }
%endif
