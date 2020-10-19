<style>
.staff-member-detail {
	display: none;
}

.close-icon, .open-icon {
	cursor: pointer;
}
</style>

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
		"LastName" : Staff.LastName.getData(),
		"FirstName" : Staff.FirstName.getData(),
		"Department" : Staff.Department.getData(),
		"Phone" : Staff.Phone.getData(),
		"Email" : Staff.Email.getData(),
		"Initial" : initial,
		"Department" : Staff.Department.getData(),
		"Photo" : Staff.Photo.getData()
	}]>

</#list>

<section class="staff-directory row">

	<div class="col-xl-16">
		<div>Last name begins with:</div>
		<ul id="staffdirectory-alpha-filter" class="list-inline staffdirectory-alpha-filter">
			<#list initialArray?sort as i>
			<li><a href="#" data-alpha="${i}" title="Show staff whose last name begins with ${i}">${i}</a></li>
			</#list>
		</ul>

		<label class="sr-only" for="staffdirectory-search-text">Search by name</label>
		<input type="text" id="staffdirectory-search-text" class="form-control" placeholder="Search by name" />

		<label class="sr-only" for="staffdirectory-department-filter">Filter by departmentt</label>
		<select id="staffdirectory-department-filter" class="staffdirectory-department-filter form-control">
			<option value="All" selected="selected">Show all departments</option>
			<#list departmentArray as i>
			<option value="${i}">${i}</option>
			</#list>
		</select>

    	<p class="staffdirectory-showall hidden"><a href="#" id="staffdirectory-showall" title="Show all staff">Show All</a></p>

		<#assign header_initials = []>

		<#-- Here we go! -->
		<#list staffArray?sort_by("LastName") as i>
			<#assign index = header_initials?seq_index_of(i.Initial)>
			<#if index == -1 && i?index != 0>
		</section>
			</#if>
			<#if index == -1>
		<section id="staffdirectory-alpha-${i.Initial}" class="staffdirectory-alpha">
			<header class="staff-member-row">
				<h3>${i.Initial}</h3>
				<#assign header_initials = header_initials + [i.Initial]>
			</header>
			</#if>
			<#if i.FirstName != "">
				<#assign StaffName = i.FirstName>
			</#if>
			<#if i.LastName != "" && i.FirstName != "">
				<#assign StaffName = "${i.LastName}, ${i.FirstName}">
			</#if>
			<#if i.Email != "">
				<#assign emailList = i.Email?trim?split("(?!^)","r")>
			</#if>

			<div class="staff-member-row row"
				data-searchtext="${i.LastName?lower_case}, ${i.FirstName?lower_case}"
				data-department="${i.Department}"
				data-email="${emailList?reverse?join("")}">
				<div class="col-xl-5">
					<h4 class="staff-member-name">
						${StaffName}
					</h4>
				</div>
				<div class="col-xl-6">
					<#if i.Department != "">
					<span class="staff-member-department">${i.Department}</span>
					</#if>
					<div class="staff-member-detail">
						<#if i.Photo != "">
						<img class="staff-member-photo" src="/${i.Photo}" alt="Photo of ${StaffName}" />
						</#if>
					</div>
				</div>
				<div class="col-xl-4">
					<#if i.Phone != "">
					<div class="staff-member-phone">
						<a href="tel:1-${i.Phone}"> ${i.Phone} </a>
					</div>
					</#if>
					<div class="staff-member-detail">
						<div class="staff-member-contact">
							<#if i.Email != "">
							<a class="staff-member-email" title="Send email to ${StaffName}" href="#">
								<svg xmlns="http://www.w3.org/2000/svg" width="17" height="13" viewBox="0 0 17 13">
								<g fill="#3C5976">
									<path d="M0.35,12.652 L0.35,0.395 L16.525,0.395 L16.525,12.652 L0.35,12.652 Z M15.225,11.352 L15.225,1.695 L1.65,1.695 L1.65,11.352 L15.225,11.352 Z"/>
									<polygon points="1.447 .526 .557 1.474 8.509 8.935 16.445 1.474 15.555 .526 8.508 7.151"/>
								</g>
								</svg>
								<span>Email</span>
							</a>
							</#if>
							<a class="staff-member-vcard" title="Download VCF for ${StaffName}"  href="#" >
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
				<div class="col-xl-1">
					<div class="close-icon hidden">
						<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
							<g fill="#587387">
								<polygon points="5 10 13 10 13 8 5 8"></polygon>
								<path d="M9,17.5 C4.30585763,17.5 0.5,13.6941424 0.5,9 C0.5,4.30585763 4.30585763,0.5 9,0.5 C13.6941424,0.5 17.5,4.30585763 17.5,9 C17.5,13.6941424 13.6941424,17.5 9,17.5 Z M9,16.5 C13.1418576,16.5 16.5,13.1418576 16.5,9 C16.5,4.85814237 13.1418576,1.5 9,1.5 C4.85814237,1.5 1.5,4.85814237 1.5,9 C1.5,13.1418576 4.85814237,16.5 9,16.5 Z"></path>
							</g>
						</svg>
					</div>
					<div class="open-icon">
						<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
							<g fill="#3A5776">
								<path d="M10,8 L10,5 L8,5 L8,8 L5,8 L5,10 L8,10 L8,13 L10,13 L10,10 L13,10 L13,8 L10,8 Z"></path>
								<path d="M9,17.5 C4.30585763,17.5 0.5,13.6941424 0.5,9 C0.5,4.30585763 4.30585763,0.5 9,0.5 C13.6941424,0.5 17.5,4.30585763 17.5,9 C17.5,13.6941424 13.6941424,17.5 9,17.5 Z M9,16.5 C13.1418576,16.5 16.5,13.1418576 16.5,9 C16.5,4.85814237 13.1418576,1.5 9,1.5 C4.85814237,1.5 1.5,4.85814237 1.5,9 C1.5,13.1418576 4.85814237,16.5 9,16.5 Z"></path>
							</g>
						</svg>
					</div>
				</div>
			</div>
		</#list>
	</div>
</section>

<script>

var cmap = cmap || {};
cmap.staffDirectory = cmap.staffDirectory || {};
cmap.staffDirectory.filterState = {};
cmap.staffDirectory.cards = [];

cmap.staffDirectory.populateCards = function() {
<#list StaffMember.getSiblings() as Staff>
	<#assign emailList = Staff.Email.getData()?trim?split("(?!^)","r")>
	<#assign email = emailList?reverse?join("")>

	<#assign cardArray = []>
	<#assign cardArray = cardArray + ["BEGIN:VCARD"]>
	<#assign cardArray = cardArray + ["VERSION:4.0"]>
	<#assign cardArray = cardArray + ["N:${Staff.LastName.getData()},${Staff.FirstName.getData()};;;"]>
	<#assign cardArray = cardArray + ["FN:${Staff.FirstName.getData()} ${Staff.LastName.getData()}"]>
	<#assign cardArray = cardArray + ["ORG:Chicago Metropolitan Agency for Planning"]>
	<#assign cardArray = cardArray + ["TITLE:${Staff.Title.getData()}"]>
	<#assign cardArray = cardArray + ["TEL;TYPE=work,voice;VALUE=uri:tel:${Staff.Phone.getData()}"]>
	<#assign cardArray = cardArray + ["EMAIL:${email}"]>
	<#assign cardArray = cardArray + ["END:VCARD"]>

	cmap.staffDirectory.cards.push({
		email: "${emailList?reverse?join("")}",
		vcard: "${cardArray?join("\\n")}"
	})
</#list>
};

cmap.staffDirectory.getCard = function(email) {
	var card = cmap.staffDirectory.cards.filter(function(card) {
		return card.email === email;
	});
	console.log(card);
	return card;
};

cmap.staffDirectory.executeFilter = function () {

    var filterAlpha = cmap.staffDirectory.filterState.alpha.toUpperCase();
    var filterDepartment = cmap.staffDirectory.filterState.department;
    var filterName = cmap.staffDirectory.filterState.name.toLowerCase();

    $('.staffdirectory-showall').addClass('hidden');
	$('.staffdirectory-alpha').show();

    if (filterDepartment !== 'All') {
        $('.staffdirectory-showall').removeClass('hidden');
        $('div.staff-member-row[data-department="' + filterDepartment + '"]').show();
        $('div.staff-member-row:not([data-department="' + filterDepartment + '"])').hide();
    } else {
        $('div.staff-member-row').show();
    }

    if ($.trim(filterName) !== '') {
        $('.staffdirectory-showall').removeClass('hidden');
        $('div.staff-member-row:not([data-searchtext*="' + filterName + '"])').hide();
    }

    if ($.trim(filterAlpha) !== '') {
        $('.staffdirectory-showall').removeClass('hidden');
        $('.staffdirectory-alpha').hide();
        $('#staffdirectory-alpha-'+filterAlpha).show();
	}

    if (!$('.staffdirectory-member:visible').length) {
        $('.staffdirectory').append('<p class="no-results">Name not found</p>');
    } else {
        $('.staffdirectory').find('.no-results').remove();
    }
};

cmap.staffDirectory.resetFilter = function() {

    $('#staffdirectory-department-filter').val('All');
    $('#staffdirectory-search-text').val('');

    cmap.staffDirectory.filterState.alpha = '';
    cmap.staffDirectory.filterState.department = 'All';
    cmap.staffDirectory.filterState.name = '';

	$('.staff-member-detail').hide();
    cmap.staffDirectory.executeFilter();
}

cmap.staffDirectory.bindEvents = function () {

    $('#staffdirectory-department-filter').on('change', function () {
        cmap.staffDirectory.filterState.department = $(this).val();
        cmap.staffDirectory.executeFilter();
    });

    $('#staffdirectory-search-text').on('keypress', function (e) {
        var p = e.which;
		console.log(p);
        if (p === 13) {
            cmap.staffDirectory.filterState.name = $(this).val();
            cmap.staffDirectory.executeFilter();
        }
    });

    $('#staffdirectory-showall').on('click', function(e) {
        e.preventDefault();
        cmap.staffDirectory.resetFilter();
    });

    $('#staffdirectory-alpha-filter').on('click', 'a', function(e) {
        e.preventDefault();
        cmap.staffDirectory.filterState.alpha = $(this).data('alpha');
        cmap.staffDirectory.executeFilter();
    });

	$('.open-icon, .close-icon').on('click', function(e) {
		var $row = $(this).closest('div.staff-member-row');
		$row.find('.staff-member-detail').slideToggle();
		$row.find('.open-icon, .close-icon').toggleClass('hidden');
    });

	$('.staff-member-vcard').on('click', function(e) {
		<#--  TODO: add delay with indicator here  -->
		var $row = $(this).closest('div.staff-member-row');
		var email = $row.data('email');
		var cards = cmap.staffDirectory.getCard(email);
		if (cards.length === 1) {
			var download = $row.data('searchtext').replace(/[^a-z0-9+]+/gi, '') + '.vcf';
			var href = 'data:text/vcard;base64,' + btoa(cards[0].vcard.replace(email, email.split('').reverse().join('')));
			$(this).attr({
				download: download,
				href: href
			});
		}
	});

	$('.staff-member-email').on('click', function(e) {
		<#--  TODO: add delay with indicator here  -->
		var $row = $(this).closest('div.staff-member-row');
		var address = $row.data('email').split('').reverse().join('');
		$(this).attr('href','mailto:' + address);
	});
};

$(function() {
	cmap.staffDirectory.populateCards();
    cmap.staffDirectory.resetFilter();
    cmap.staffDirectory.bindEvents();
});
</script>
