Return-Path: <linux-s390+bounces-21712-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kcKuHVDJTGoOpwEAu9opvQ
	(envelope-from <linux-s390+bounces-21712-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 07 Jul 2026 11:39:28 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E119D719E4D
	for <lists+linux-s390@lfdr.de>; Tue, 07 Jul 2026 11:39:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CMxUF64D;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21712-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21712-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D0A3302BBCE
	for <lists+linux-s390@lfdr.de>; Tue,  7 Jul 2026 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD539AD49;
	Tue,  7 Jul 2026 09:32:28 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0C397E9D;
	Tue,  7 Jul 2026 09:32:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416748; cv=none; b=Mdd59VRMItaOj+Qs3TTzKNKg6W9rD4CWhgFjwvIgdGZqE+l2OhFSKxq6SiWFDhTYFrPigtsRclIyuBcxSOUSyeCULCIw1IXQXU6GRnyeUCcWIJ1BAtZkgKopF0nYN8evEr8yWVrpV8+TzCX+Gytd9z0ugTIUKTz6+2YAoJQvEQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416748; c=relaxed/simple;
	bh=Ar7Wc8cv4gYk0aBdp5wDndwyQ0KPIb/wZDaPYg6MvR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dwF9jLytRGUdXhkqMSqG7YgFpwz1gMOd0BWlfTr8LcckM0RjZx2/77in4aN0VSdQ5NK/we0EnWSjX+L9SpQXvAvAv295XD+R/z2P82/XN2ZEdv2nGyKb4Oxw1m7Z5CMr/dRYwSIHE2N+bus8wN2NOXuJhwgCZTwqxUipQZ/N3WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMxUF64D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3A81F000E9;
	Tue,  7 Jul 2026 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783416746;
	bh=aE4Vyr1iucpcDGTc27H9QnFGhm0W1ANEmFdU9uGr50E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CMxUF64DaiVFvz080cQbbSain2VzLoNKyq0zhOGG//APVpBmXgHvLxCua1bYZNaVL
	 fGGQhhGMAzLOkQySGxxP+ZUHpM6wLlfzr/aq5wQmtzokAdeqKN9PAOsCHCGjWZv+jW
	 7DuNnX9BMMDjQ3OEBtBIIIb3W+r5aICOltOZ8SY6rTgqq7ER7dAQQR/zgqfZuJ5PBQ
	 wuW5Sfk2o/bHcXWUrPUf8b2vIe4WyxURigvM+eDV6l6UDAQbbx/czBRvpWVF1rGyx3
	 P6+YazfuraMzSjaWLetgjovzQKomekp53qW3NWJjoVVzHHCG1sDCsA4IOmPMg7+PBA
	 WV0s1ieJHQh/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/15] s390/vfio-ap: Callback to get the size of data
 to be migrated during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260707090226.3206695-14-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-14-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:32:26 +0000
Message-Id: <20260707093226.7A3A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21712-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akrowiak@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E119D719E4D

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] vfio_ap_resuming_write leaks memory and fails subsequent writes if=
 userspace performs a partial write during migration resuming.
- [High] vfio_ap_get_config does not initialize the config_sz field of the =
payload, sending 0 to the migration target.
--

--- Patch [13]: [PATCH v4 13/15] s390/vfio-ap: Callback to get the size of =
data to be migrated during guest migration ---
commit cf31fd21666e32de812c2582ed7358837c47d2bd
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Callback to get the size of data to be migrated during guest =
migration

This commit adds a callback to get the estimated data length required
to complete reading of the vfio device's internal state. This is mandatory
for VFIO_DEVICE_FEATURE_MIGRATION support.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 572db04c4ac15..83e1ce2c40c0c 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1283,7 +1283,18 @@ static int vfio_ap_get_state(struct vfio_device *v=
dev,
>  static int vfio_ap_get_data_size(struct vfio_device *vdev,
>  				 unsigned long *stop_copy_length)
>  {
> -	return -EOPNOTSUPP;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	size_t qinfo_sz;
> +	int num_queues;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
> +	num_queues =3D vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
> +	qinfo_sz =3D num_queues * sizeof(struct vfio_ap_queue_info);
> +	*stop_copy_length =3D qinfo_sz + sizeof(struct vfio_ap_config);
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	return 0;
>  }
> =20
>  static const struct vfio_migration_ops vfio_ap_migration_ops =3D {

[Severity: High]
Does vfio_ap_resuming_write() leak the newly allocated ap_config and fail
subsequent writes if userspace performs a partial write during migration
resuming?

If a partial write occurs during vfio_ap_resuming_write() (i.e. *pos =3D=3D=
 0
but len < cfg_sz), the newly allocated ap_config is not saved to
mig_data->resuming_mig_state.ap_config because the check
if (*pos + len =3D=3D cfg_sz) is false.

The function then bypasses the cleanup label:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write() {
...
	ret =3D len;
	*pos +=3D len;
	goto done;

cleanup:
	kfree(ap_config);
done:
...
}

Because the pointer was never saved in the first partial write, the
subsequent partial write fails this validation, returning -EFAULT,
which permanently fails the migration:

drivers/s390/crypto/vfio_ap_migration.c:validate_resuming_write_parms() {
...
	if ((!matrix_mdev->mig_data->resuming_mig_state.ap_config && *pos !=3D 0) =
||
	    (matrix_mdev->mig_data->resuming_mig_state.ap_config && *pos =3D=3D 0)=
) {
		ret =3D -EFAULT;
...
}

[Severity: High]
Can vfio_ap_get_config() send an uninitialized config_sz field to the
migration target, causing the target to fail?

In vfio_ap_get_config(), a new struct vfio_ap_config is allocated and
populated, but its config_sz field is never initialized and remains 0.
This structure is sent verbatim over the migration stream to the target hos=
t:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_get_config() {
...
	ap_configuration =3D kzalloc(*ap_config_size, GFP_KERNEL_ACCOUNT);
	if (!ap_configuration)
		return -ENOMEM;

	ap_configuration->num_queues =3D num_queues;

	ret =3D vfio_ap_store_queue_info(matrix_mdev, ap_configuration);
...
}

If the target host receives a partial write and calls reallocate_ap_config(=
),
it reads cur_cfg_sz =3D ap_config->config_sz, which is 0.

This causes the target to take the wrong reallocation path, shrinking the
buffer incorrectly:

drivers/s390/crypto/vfio_ap_migration.c:reallocate_ap_config() {
...
	cur_cfg_sz =3D ap_config->config_sz;
	num_queues =3D ap_config->num_queues;

	/* ... */
	if (cur_cfg_sz >=3D sizeof(struct vfio_ap_config)) {
		new_cfg_sz =3D calculate_ap_config_size(num_queues);
		// ...
	} else {
		new_cfg_sz =3D cur_cfg_sz + len;
	}
...
}

The validation if (*pos + len > cfg_sz) then fails because cfg_sz evaluates
to len and *pos > 0, causing the buffer to be freed and migration to
fail with -EIO.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D13

