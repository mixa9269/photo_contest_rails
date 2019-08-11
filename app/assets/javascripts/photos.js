$(document).on('ready turbolinks:load', () => {
  const $comments = $('#comments');
  
  if ($comments[0]) {
    const { 
      profilePictureURL, 
      photoId,
    } = window.pc;

    const handleCommentPost = (commentJSON, success, error) => {
      $.ajax({
        type: 'post',
        url: `/api/v1/photos/${photoId}/comments/`,
        data: commentJSON,
        success: function(comment) {
          success(comment)
        },
        error: error
      });
    }

    $comments.comments({
      profilePictureURL: profilePictureURL,
      enableNavigation: false,
      enableUpvoting: false,
      highlightColor: "$color-cod-gray",
      enableEditing: false,
      postComment: handleCommentPost,
      fieldMappings: {
        created: 'created_at',
        profilePictureURL: 'profile_picture_url',
        parent: "parent_id"
      },
      timeFormatter: function(time) {
        return moment(time).fromNow();
      },
      getComments: function(success, error) {
        $.ajax({
          type: 'get',
          url: `/api/v1/photos/${photoId}/comments/`,
        success: function(comments) {
          success(comments);
        },
        error: error
      });
      }
    });
  }
})


