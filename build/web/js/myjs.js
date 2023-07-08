//function doLike(pid, uid) {
//  const d = {
//    uid: uid,
//    pid: pid,
//    operation: 'like'
//  }
//
//  $.ajax({
//    url: 'LikeServlet',
//    data: d,
//    success: function (data) {
//      console.log(data);
//      if (data.trim() === 'true') {
//        let counter = $('.like-counter');
//        let count = parseInt(counter.text());
//        count++;
//        counter.text(count);
//      }
//    },
//    error: function (jqXHR, textStatus, errorThrown) {
//      console.log(errorThrown);
//    }
//  });
//}
function doLike(pid, uid) {
    console.log(pid + "," + uid);
    
    const likeCount = $('#like-count1-' + pid);
    const count = parseInt(likeCount.text());

    // check if the user has already liked this post
    if (likeCount.hasClass('liked')) {
        // decrease the count and remove the 'liked' class from the like count
        likeCount.text(count - 1);
        likeCount.removeClass('liked');
    } else {
        const d = {
            uid: uid,
            pid: pid,
            operation: 'like'
        }

        $.ajax({
            url: "LikeServlet",
            data: d,
            success: function (data, textStatus, jqXHR) {
                console.log(data);
                if (data.trim() === 'true')
                {
                    // increase the count and add the 'liked' class to the like count
                    likeCount.text(count + 1);
                    likeCount.addClass('liked');
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(data)
            }
        });
    }
}


function dounLike(pid, uid) {
    console.log(pid + "," + uid);
    
    const likeCount = $('#like-count2-' + pid);
    const count = parseInt(likeCount.text());

    // check if the user has already liked this post
    if (likeCount.hasClass('liked')) {
        // decrease the count and remove the 'liked' class from the like count
        likeCount.text(count + 1);
        likeCount.removeClass('liked');
    } else {
        const d = {
            uid: uid,
            pid: pid,
            operation: 'unlike'
        }

        $.ajax({
            url: "LikeServlet",
            data: d,
            success: function (data, textStatus, jqXHR) {
                console.log(data);
                if (data.trim() === 'true')
                {
                    // increase the count and add the 'liked' class to the like count
                    likeCount.text(count -1);
                    likeCount.addClass('liked');
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(data)
            }
        });
    }
}
////sub
//function doSub(uid, channel_id) {
//    const subCount = $('#sub-count1-' + uid);
//    const count1 = parseInt(subCount.text());
//
//    if (subCount.hasClass('sub')) {
//        subCount.text(count1 - 1);
//        subCount.removeClass('sub');
//    } else {
//        const data = {
//            uid: uid,
//            channel_id: channel_id,
//            operation: 'sub'
//        };
//
//        $.ajax({
//            url: 'SubServlet',
//            type: 'POST',
//            data: data,
//            success: function(response) {
//                if (response.trim() === 'true') {
//                    subCount.text(count1 + 1);
//                    subCount.addClass('sub');
//                }
//            },
//            error: function(jqXHR, textStatus, errorThrown) {
//                console.log(errorThrown);
//            }
//        });
//    }
//}
//
//function dounSub(uid, channel_id) {
//    const subCount = $('#sub-count2-' + uid);
//    const count1 = parseInt(subCount.text());
//
//    if (subCount.hasClass('sub')) {
//        subCount.text(count1 - 1);
//        subCount.removeClass('sub');
//    } else {
//        const data = {
//            uid: uid,
//            channel_id: channel_id,
//            operation: 'unsub'
//        };
//
//        $.ajax({
//            url: 'SubServlet',
//            type: 'POST',
//            data: data,
//            success: function(response) {
//                if (response.trim() === 'true') {
//                    subCount.text(count1 + 1);
//                    subCount.addClass('sub');
//                }
//            },
//            error: function(jqXHR, textStatus, errorThrown) {
//                console.log(errorThrown);
//            }
//        });
//    }
//}
//

function doSub(uid, channel_id) {
  const subCount = $('#sub-count1-' + uid);
  const count1 = parseInt(subCount.text());

  if (subCount.hasClass('sub')) {
    subCount.text(count1 - 1);
    subCount.removeClass('sub');
  } else {
    const data = {
      uid: uid,
      channel_id: channel_id,
      operation: 'sub'
    };

    $.ajax({
      url: 'SubServlet',
      type: 'POST',
      data: data,
      success: function(response) {
        if (response.trim() === 'true') {
          subCount.text(count1 + 1);
          subCount.addClass('sub');
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.log(errorThrown);
      }
      
    });
  }
}

function dounSub(uid, channel_id) {
  const subCount = $('#sub-count2-' + uid);
  const count1 = parseInt(subCount.text());

  if (subCount.hasClass('sub')) {
    subCount.text(count1 + 1);
    subCount.removeClass('sub');
  } else {
    const data = {
      uid: uid,
      channel_id: channel_id,
      operation: 'unsub'
    };

    $.ajax({
      url: 'SubServlet',
      type: 'POST',
      data: data,
      success: function(response) {
        if (response.trim() === 'true') {
          subCount.text(count1 - 1);
          subCount.addClass('sub');
        }
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.log(errorThrown);
      }
      
    });
  }
}
