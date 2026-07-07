Return-Path: <linux-s390+bounces-21715-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WTLdF5fKTGpYpwEAu9opvQ
	(envelope-from <linux-s390+bounces-21715-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 07 Jul 2026 11:44:55 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B069B719EE9
	for <lists+linux-s390@lfdr.de>; Tue, 07 Jul 2026 11:44:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QIORWAzm;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21715-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21715-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D0E308D490
	for <lists+linux-s390@lfdr.de>; Tue,  7 Jul 2026 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408F93B47CA;
	Tue,  7 Jul 2026 09:38:47 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE83B5E07
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 09:38:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417125; cv=none; b=Gxj2PC5kT0EoMhkJewDRnbJ8e+p7sICgE5oYetTTpIzj+AQo9Z0zzwP1LKDmmvKMFvyM/cDx5hMxgfzHFOSnNP7Vm0UNL1kFX5SWPNTzU4L/1vRCtrw+CduCtDrNHMiOXKJMyoLvkj8a9FZRgB9nwwA/Bp8MLdBWhdin6JfC0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417125; c=relaxed/simple;
	bh=qs15xkvATvN/mDe6CAgVPsmas5SJo5U6Ae43ixBF52c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mHlzGBBXaH4Hw+tbd/EnZK2bRmS2IGybCV0SV0kMhh5P+RnKvPebmGDESMiJXl2S58olgTDFkJR1bE+bu2MMhcnSb3LGD+s0l21QbhWzXCjATy0KFxANEYsya6N8DHCBwxFAxDxTnUn2S1RElddqTWfbmyzVs4zf2Yv/K0EYRCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QIORWAzm; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783417119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5asutad2zaIsOememTKrTQLyi4rB2Il2HvaVX8/4Ogk=;
	b=QIORWAzmLE0j3edg2L8gcsRXTjquOWMEjk/Rp5yyLBMemzzpiGDmBP/kP4TdHUKwLRcJ2F
	HMgjYU7gVfrbbSiq8m0RXUfOIKhwBC2hbYSiYCvB+pfBXCEQU+50pFyW7fIONIORB9oppO
	8fdFhpAhpp0qiJfaxByJPW78wMD7m+c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-BK87US3POI-YfYWy3FrkAA-1; Tue,
 07 Jul 2026 05:38:37 -0400
X-MC-Unique: BK87US3POI-YfYWy3FrkAA-1
X-Mimecast-MFC-AGG-ID: BK87US3POI-YfYWy3FrkAA_1783417116
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09DBA180130E;
	Tue,  7 Jul 2026 09:38:36 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21D2B1955F71;
	Tue,  7 Jul 2026 09:38:34 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v10 00/21] target/s390x: Extend qemu CPACF support
In-Reply-To: <20260706094317.17032-1-freude@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260706094317.17032-1-freude@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 07 Jul 2026 11:38:32 +0200
Message-ID: <87jyr7jg13.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:richard.henderson@linaro.org,m:iii@linux.ibm.com,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:fcallies@linux.ibm.com,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-21715-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[cohuck@redhat.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cohuck@redhat.com,linux-s390@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B069B719EE9

On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:

> This patch series extends the s390 qemu CPACF support to be able to
> run a subset of the CPACF instruction cross platform. There have been
> requests on the kernel crypto mailing list about a way to test
> s390 specific crypto implementations. For example a way to test
> s390 CPACF exploitation code like the s390_aes.ko kernel module.
>
> So here now is a set of patches verified on x86 and s390 which
> over (slow but working) support for a subset of the subfunctions of
> some of the CPACF instructions.

Hi,

I wanted to pick this, but unfortunately, there are some problems with
it, as spotted by checkpatch (sadly, I did not see this earlier, and
softfreeze is upon us...)

- Licensing information: new files (e.g. cpacf.h) must use an SPDX
  identifier instead of licence boilerplate text - this needs to be fixed
- some files are using tabs instead of spaces in some places
- there are also some other moans (less important), but you may want to
  look at them anyway (the long lines are not really a problem)

Cornelia


