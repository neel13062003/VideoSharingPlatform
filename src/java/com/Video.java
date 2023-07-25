package com;
public class Video {
    private int videoId;
    private String title;
    private String description;
    private String videoUrl;
    private String thumbnailUrl;
    private String owner;
    private int ownerId;

    // Constructor
    public Video(int videoId, String title, String description, String videoUrl, String thumbnailUrl, String owner, int ownerId) {
        this.videoId = videoId;
        this.title = title;
        this.description = description;
        this.videoUrl = videoUrl;
        this.thumbnailUrl = thumbnailUrl;
        this.owner = owner;
        this.ownerId = ownerId;
    }

    public int getVideoId() {
        return videoId;
    }

    public void setVideoId(int videoId) {
        this.videoId = videoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public String getThumbnailUrl() {
        return thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }
    @Override
    public String toString() {
        return "Video [videoId=" + videoId + ", title=" + title + ", description=" + description + ", videoUrl="
                + videoUrl + ", thumbnailUrl=" + thumbnailUrl + ", owner=" + owner + ", ownerId=" + ownerId + "]";
    }
   
}
