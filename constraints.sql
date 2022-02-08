-- 프로필 제약조건
ALTER TABLE nf_profile MODIFY autoplay_episode DEFAULT 'true';
ALTER TABLE nf_profile MODIFY autoplay_previews DEFAULT 'true';
ALTER TABLE nf_profile MODIFY lang_id DEFAULT 1 NOT NULL; 
ALTER TABLE nf_profile MODIFY screen_info_id DEFAULT 4 NOT NULL;
ALTER TABLE nf_profile MODIFY acc_id NOT NULL;
ALTER TABLE nf_profile MODIFY limit_id NOT NULL;
ALTER TABLE nf_profile MODIFY profile_id CHECK(substr(profile_id, 8) <= 5);

