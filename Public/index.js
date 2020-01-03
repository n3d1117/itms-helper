document.addEventListener('DOMContentLoaded', function() {
	
	// Enable/Disable generate button
	$(".demo-form").keyup(function() {

		let link = $('#inputLink').val();
		let bundle = $('#inputBundle').val();
		let title = $('#inputTitle').val();
        let version = $('#inputVersion').val();

		if (isURL(link) && bundle && title) {
			$(".generate-btn").removeAttr('disabled');
		} else {
			$(".generate-btn").prop('disabled', true);
		}
		
	});

	// Generate button clicked
	$(".generate-btn").click(function(e) {
		e.preventDefault()

		let link = $('#inputLink').val();
		let bundle = $('#inputBundle').val();
		let title = $('#inputTitle').val();
        let version = $('#inputVersion').val();

		// Call API
		$.getJSON(`request?link=${link}&bundle=${bundle}&title=${title}&version=${version}`, function(response) {
			$(".completion-text").removeClass("hidden");
			$(".completion-url").attr("href", `plists/${response.uuid}.plist`)
			$(".completion-itms-url").attr("href", `itms-services://?action=download-manifest&url=https://itms-plist-helper.herokuapp.com/plists/${response.uuid}.plist`)
		});
	});
	
	function isURL(str) {
		return /^(?:\w+:)?\/\/([^\s\.]+\.\S{2}|localhost[\:?\d]*)\S*$/.test(str); 
	}
})
