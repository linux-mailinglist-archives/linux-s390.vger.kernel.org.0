Return-Path: <linux-s390+bounces-21360-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CMbHGqqyQ2prfQoAu9opvQ
	(envelope-from <linux-s390+bounces-21360-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 14:12:26 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD8F6E4084
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 14:12:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=il7bJ5X7;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21360-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21360-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D4363261486
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90BB3FFACC;
	Tue, 30 Jun 2026 11:49:36 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12B73F20E7;
	Tue, 30 Jun 2026 11:49:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820176; cv=none; b=ed7zRsPKqbR0hy5jCL3rzcUF1f46ls/7TRyuZP9wU7AlV4GHjQAoSpYg/4S7L7LUvN4WKN/5brr+zifUxdEs+zpJpAIdY1nXCCw1tetVX6r1q0cKp3sUXbPDRaNxzdsIH9HQPCc5FRaf4xUUDpyQpMrUFTit44L2SPUtp1IElUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820176; c=relaxed/simple;
	bh=4JADe2P92Rb3cOEVZWXblRdvcy38Nz0uPOylDyxxuAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PLsvAaZ8I6PfhVER3JpAyaT1wqlaUL2QsqK4WLXvqyaSLF1d6UczXPB/iMWkXwGI/JCrRbQ9uV3dGaeGJnC5erJFTIgyuQSBENl3T6cNLYcWWiPaYnIpGmZZjRpXJv8xxVpyIFiDqbRNtniXDAfqsOFm8p0NoZfuV06JoKjLLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=il7bJ5X7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012BD1F000E9;
	Tue, 30 Jun 2026 11:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782820175;
	bh=yfgI+4xQU7j0dBWMpZqnu+GvOQTVLtHEklk3BeeWjmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=il7bJ5X7qIv/0qNvQO42Aw7VK9g2hD2Z/x/CbF28DB0Wjvyb7TzocA26/cFxMyoz0
	 OUE3yviAcHBWmHv/xZPlDt3667N/Z7oX0EM/xvZIkt0+NbRYYXxx9kgyCcCcefamI8
	 7n9KdFpXUx3WnLAzdaTs8mqL0SeqOv8SRDaoiJaklmJ9KbvcE5bpLvzjWRmgCwOP+w
	 WT8Te4FXI8uNo3+8eHEFIZdhDzYBycoG133q7Y5KB2ybeVwWCF84VdjqPypXTZGGlB
	 n4onYrAsIbyf9NOt26ozOJiq6MMZuYsMov1ngazC+4hsXOMZAqbjdd/MEIzoAexzNX
	 36CBw029GL7XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/15] s390/vfio-ap: Callback to get the size of data
 to be migrated during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260630104132.1598851-14-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-14-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:49:34 +0000
Message-Id: <20260630114935.012BD1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21360-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akrowiak@linux.ibm.com,m:kvm@vger.kernel.org,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBD8F6E4084

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Chunked writes to the resuming migration file descriptor cause=
 a memory leak and subsequent NULL pointer dereference.
- [High] Migration config size is uninitialized on the source, breaking chu=
nked reallocation on the destination.
--

commit 267d5567c135fa27576ba7a999b70cfabea69848
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Callback to get the size of data to be migrated during guest =
migration
   =20
Callback to get the estimated data length of the data that will be required
to complete reading of the vfio device's internal state. It's mandatory for
VFIO_DEVICE_FEATURE_MIGRATION migration support.

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

[Severity: Critical]
This is a pre-existing issue, but chunked writes to the resuming migration
file descriptor can cause a memory leak and subsequent NULL pointer
dereference.

When userspace writes resuming migration data in chunks (a write where
*pos + len < cfg_sz), vfio_ap_resuming_write() successfully processes the
chunk but bypasses saving the newly allocated ap_config to mig_data, and
fails to free it:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write() {
...
	if (*pos =3D=3D 0) {
		ret =3D allocate_ap_config(&ap_config, buf, len);
...
	} else {
...
	}
...
	/* Check if we've completed writing the entire configuration */
	if (*pos + len =3D=3D cfg_sz) {
...
		if (!ret) {
			mig_data->resuming_mig_state.ap_config =3D ap_config;
			mig_data->resuming_mig_state.config_sz =3D cfg_sz;
		}
...
	}

	ret =3D len;
	*pos +=3D len;
	goto done;

cleanup:
	kfree(ap_config);
done:
...
}

If the first write is a partial chunk, ap_config is allocated but the
function skips assigning it to mig_data->resuming_mig_state.ap_config and
jumps to done, leaking ap_config.

On the next chunk write (*pos > 0), the else branch reads
mig_data->resuming_mig_state.ap_config which is still NULL. It passes it to
reallocate_ap_config(), where it is unconditionally dereferenced:

drivers/s390/crypto/vfio_ap_migration.c:reallocate_ap_config() {
	struct vfio_ap_config *ap_config =3D *mig_ap_config;
...
	cur_cfg_sz =3D ap_config->config_sz;

Can this sequence cause a memory leak on partial writes, followed by a NULL
pointer dereference on the next chunk write?

[Severity: High]
This is a pre-existing issue, but the migration config size appears to be
left uninitialized on the source, which can break chunked reallocation on
the destination.

In vfio_ap_get_config(), ap_configuration is allocated via kzalloc but the
config_sz field is never populated:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_get_config() {
...
	*ap_config_size =3D vfio_ap_config_size(matrix_mdev, &num_queues);

	ap_configuration =3D kzalloc(*ap_config_size, GFP_KERNEL_ACCOUNT);
	if (!ap_configuration)
		return -ENOMEM;

	ap_configuration->num_queues =3D num_queues;
...
}

Because config_sz remains 0, the source sends a zeroed config_sz to
userspace. On the destination, vfio_ap_resuming_write() copies this
structure from userspace. If a subsequent chunk triggers
reallocate_ap_config(), it reads the 0 size and reallocates the buffer to
merely len. This causes the subsequent validation:

	if (*pos + len > cfg_sz) {
		ret =3D -EIO;
		goto cleanup;
	}

to evaluate as true (since *pos + len > len is true when *pos > 0),
aborting the migration with -EIO.

Should config_sz be initialized in vfio_ap_get_config() before it is sent
to the destination?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D13

