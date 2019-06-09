    function get_users_account_edit()
    {
    	$.ajax({
    		type:"get",
    		url:"/users/edit"
    	})
    }
    function toggle_club_admin(club_id,user_id)
    {
    	$.ajax({
    		type:'post',
    		url:'/communities/toggle_club_admin',
    		headers: {
    			'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    		},
    		data:{"id":club_id, "user_id":user_id}
    	})
    }