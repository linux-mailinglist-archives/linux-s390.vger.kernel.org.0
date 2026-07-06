Return-Path: <linux-s390+bounces-21577-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UD3PDB5hS2rNQQEAu9opvQ
	(envelope-from <linux-s390+bounces-21577-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 10:02:38 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9EB70DDF7
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 10:02:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=EEtsYqPa;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21577-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21577-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8BC93004C34
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jul 2026 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9432F3ECBEB;
	Mon,  6 Jul 2026 08:02:35 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F43DD50D
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 08:02:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324954; cv=none; b=rp5oTPrI35Pxs6yMUxzNXpnpsPaeD/fL7mab/hw+D6b0QRhHohh0WV5T0C4Rt5PIgEMfZI86i2/qszw3b1/TLXlYDWx+Xf1tu/XXKE9GiryJsKn9c9+YjUnA5rF12mZfDw9ebkbb8vSghWy4PlM83kdoHpx/U4DZnhiK8EbU1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324954; c=relaxed/simple;
	bh=KPf6QSnuTBye0ku4y+66UJmJ/y+HGg1H4Wt97siv1Z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ju2+p/fFBUJdYVBhQX0PkgTXHPh2I6Ohh8iFq5ebt40H4dgS/nmdZrXsOjSCI1Ue/QWp6yVlX5jP0qa4jOvOkzIqn/12ucVQHTziLeqlqs2tK1OTNaQWMT0npicAsBifTLNuXFVqTuDYIqiL2oyPG9zxtcSMGp0koIDcB4aDqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEtsYqPa; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783324932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqQoiX8nOstIqMDv9TBNeaeMATrv7hzlmItcdj7mYtY=;
	b=EEtsYqPa9SHlpLJOnQ/RiPDqxdfxTTAaJuaVhaOGxsX/mtXP0taPrX8NO4fk64VnKNxdtD
	fodO2GkS0pExKY2M65yl56dQuvV0RMrUZNsFzhuRZbJOB2dcQoJahqdVpGPALw69QCZhLV
	yIDBTBKsIHkmrfQILkeoRxzSybbIze8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-f90MF37vM6-j2tZnSLWTLg-1; Mon,
 06 Jul 2026 04:02:07 -0400
X-MC-Unique: f90MF37vM6-j2tZnSLWTLg-1
X-Mimecast-MFC-AGG-ID: f90MF37vM6-j2tZnSLWTLg_1783324925
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64B2C195607C;
	Mon,  6 Jul 2026 08:02:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6298F18005A2;
	Mon,  6 Jul 2026 08:02:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: freude@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v9 03/21] target/s390x: Move cpacf sha512 code into a
 new file
In-Reply-To: <3ea0066d4b1f2e1e4a604286e49ef12b@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260701164650.95760-1-freude@linux.ibm.com>
 <20260701164650.95760-4-freude@linux.ibm.com> <877bnckuuk.fsf@redhat.com>
 <3ea0066d4b1f2e1e4a604286e49ef12b@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 06 Jul 2026 10:02:02 +0200
Message-ID: <871pdglf5x.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:richard.henderson@linaro.org,m:iii@linux.ibm.com,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:fcallies@linux.ibm.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[cohuck@redhat.com,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-21577-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cohuck@redhat.com,linux-s390@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD9EB70DDF7

On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 2026-07-03 16:31, Cornelia Huck wrote:
>> On Wed, Jul 01 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
>> 
>>> Move the cpacf sha512 implementation into a new file
>>> cpacf_sha512.c. Add this new file to the build and use the cpacf.h
>>> header file storing function the prototypes.
>>> 
>>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>> ---
>>>  target/s390x/tcg/cpacf.h         |   5 +
>>>  target/s390x/tcg/crypto_helper.c | 222 
>>> -------------------------------
>>>  target/s390x/tcg/meson.build     |   1 +
>>>  3 files changed, 6 insertions(+), 222 deletions(-)
>> 
>> Forgot to commit the new cpacf_sha512.c file?
>
> Yes - the last rework ...
> Shall I send out v10 with only this missing file fixed ?

Just send out the complete series, that makes it easier to merge.


