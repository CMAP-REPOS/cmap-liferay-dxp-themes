<#assign staffArray = []>
<#assign initialArray = []>
<#assign departmentArray = []>

<#list StaffMember.getSiblings() as Staff>

	<#assign initial = Staff.LastName.getData()[0]>
	<#assign index = initialArray?seq_index_of(initial)>
	<#if index == -1>
		<#assign initialArray = initialArray + [initial]>
	</#if>
	
	<#assign department = Staff.Department.getData()>
	<#assign deptindex = departmentArray?seq_index_of(department)>
	<#if deptindex == -1>
		<#assign departmentArray = departmentArray + [department]>
	</#if>

	<#assign staffArray = staffArray + [{ 
		"object" : Staff, 
		"LastName" : Staff.LastName.getData(), 
		"FirstName" : Staff.FirstName.getData(), 
		"Department" : Staff.Department.getData(), 
		"Phone" : Staff.Phone.getData(), 
		"Email" : Staff.Email.getData(), 
		"Initial" : initial
	}]>
</#list>


<section class="staff-directory row">

	<div class="left-col col-xl-3">
		<div>Last name begins with:</div>
		<ul>
			<#list initialArray?sort as i>
				<li><a href="#">${i}</a></li>
			</#list>
		</ul>
	</div>

	<div class="center-col col-xl-10">

		<h1>Staff Directory</h1>

		<div class="staff-member-directory">
		<#assign header_initials = []>

		<#-- Here we go! -->
		<#list staffArray?sort_by("LastName") as i>


			<#assign index = header_initials?seq_index_of(i.Initial)>
			<#if index == -1>
			<header class="staff-member-row">
				<h3>${i.Initial}</h3>
				<#assign header_initials = header_initials + [i.Initial]>
			</header>
			</#if>
				
			<div class="staff-member-row row">

				<div class="col-xl-5">
					<h4 class="staff-member-name"> 
						<#if i.LastName != ""> ${i.LastName}<#if i.FirstName != "">, </#if> </#if>
						<#if i.FirstName != ""> ${i.FirstName} </#if>
					</h4>

					<#if i.object.Photo.getData() != "">
					<img class="staff-member-photo" src="${i.object.Photo.getData()}" />
					</#if>
				</div>
				

				<div class="col-xl-6">
					<#if i.Department != "">
					<span class="staff-member-department">${i.Department}</span>
					</#if>
				</div>	

				<div class="col-xl-5">
					<#if i.Phone != "">
					<div class="staff-member-phone">
						<a href="tel:1-${i.Phone}"> ${i.Phone} </a>
					</div>
					</#if>
					
					<div class="staff-member-contact">
						<#if i.Email != "">
						<a class="staff-member-email" href="mailto:${i.Email}">
							<svg xmlns="http://www.w3.org/2000/svg" width="17" height="13" viewBox="0 0 17 13">
							  <g fill="#3C5976">
							    <path d="M0.35,12.652 L0.35,0.395 L16.525,0.395 L16.525,12.652 L0.35,12.652 Z M15.225,11.352 L15.225,1.695 L1.65,1.695 L1.65,11.352 L15.225,11.352 Z"/>
							    <polygon points="1.447 .526 .557 1.474 8.509 8.935 16.445 1.474 15.555 .526 8.508 7.151"/>
							  </g>
							</svg>
							<span>Email</span> 
						</a>
						</#if>

						<a class="staff-member-vcard" href="/c/portal/staff_directory_support/download_vcard"> 
							<svg xmlns="http://www.w3.org/2000/svg" width="17" height="13" viewBox="0 0 17 13">
							  <g fill="#3C5976" fill-rule="evenodd">
							    <path d="M10.8039 5.522C10.8039 4.143 9.6849 3.022 8.3039 3.022 6.9229 3.022 5.8039 4.143 5.8039 5.522 5.8039 6.901 6.9229 8.022 8.3039 8.022 9.6849 8.022 10.8039 6.901 10.8039 5.522zM4.07565677 11.352C4.96180221 9.95161938 6.52443705 9.022 8.3039 9.022 10.083363 9.022 11.6459978 9.95161938 12.5321432 11.352L4.07565677 11.352z"/>
							    <path fill-rule="nonzero" d="M0.216,12.652 L0.216,0.395 L16.391,0.395 L16.391,12.652 L0.216,12.652 Z M15.091,11.352 L15.091,1.695 L1.516,1.695 L1.516,11.352 L15.091,11.352 Z"/>
							  </g>
							</svg>
							<span>VCard</span> 
						</a>
					</div>
				</div>

			</div>
			
		</#list>
		</div>

	</div>

	<div class="left-col col-xl-3">
		<input type="text" id="staffdirectory_search_text" placeholder="Search by name" />
		<a id="staffdirectory_search_button" href="#"><i class="fa fa-search"></i></a>
		<select class="staffdirectory-department-filter">
			<option value="All">Show Department...</option>
			<#list departmentArray as i>
				<option value="${i}">${i}</option>
			</#list>
		</select>
		
		<h2>General contact numbers:  312-454-0400 (voice), 312-454-0411 (fax)</h2>
		<a href="http://localhost:8080/documents/10180/78142/CMAPorgchart.pdf/95e32dc5-fcfe-4422-8465-3fe2182d483d">
			CMAP organizational chart
		</a> 
		<span>(Updated May, 25, 2017)</span>
	</div>

</section>
