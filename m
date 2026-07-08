Return-Path: <linux-s390+bounces-21815-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kvk/FRleTmqMLQIAu9opvQ
	(envelope-from <linux-s390+bounces-21815-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 16:26:33 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FF172751E
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 16:26:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=C1k7VOF0;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21815-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21815-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91EC2300DE19
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jul 2026 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555263DD521;
	Wed,  8 Jul 2026 14:16:15 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248A3783C3
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 14:16:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520175; cv=none; b=eUcM+beOisbD0Unm8hFkwwTPXqg9op4+fyzpIyviQBxMj+tHmN9SDHlYibvVdlH/6F7pb7tbD11NbklWrfdhjHbDZvsK/eHdbHi53Q2pZJTfGruP5poApmZ3ukQ5D0zsQgettgLCy8e+eW/++Dxc9wsRFl5yoPh/MR1N7F24qWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520175; c=relaxed/simple;
	bh=OxcZAmS8zOVxXWAJuECohe0LAmHJKy+SdiHxFnYCvh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N5R1QjEyBsGcrjp0VUXghx5CuaVi6T379XD8yseHax+EYuHHftIeXGcE3sZ/THW7WSX6U1VUt6mO/pWHDxbNfmhNl3G35n73jbPsBgaVkWvbmFV4PskODLfIEJXrq7kf56eECybqsI8YHEen1LJ3+3UNAClmnFMXjJJ1wv5h6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1k7VOF0; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783520172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zc3P5sGLUXZ2J+nNypqlfuqU9Vng109dcjBCmM7bwyA=;
	b=C1k7VOF0ltk/rYJjSKALvl8eaAHdpjDb4DwF70RjyojIaBT8pPRc6iB+Surlv41s4DYKng
	87u5TYHkFVXD6DHDsfaak2b0oe1q7NEY6PbM7NF4cFkXjbhh7jmQPop1ZptkBT417KbNbk
	cJQy3RZlR41Ijk5x++gypoIr8VRnfcU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-AAp6636eMG23SpQpXJl7fA-1; Wed,
 08 Jul 2026 10:16:10 -0400
X-MC-Unique: AAp6636eMG23SpQpXJl7fA-1
X-Mimecast-MFC-AGG-ID: AAp6636eMG23SpQpXJl7fA_1783520168
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E99A180059A;
	Wed,  8 Jul 2026 14:16:08 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDBBA1956086;
	Wed,  8 Jul 2026 14:16:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: freude@linux.ibm.com, Michael Tokarev <mjt@tls.msk.ru>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, qemu-stable
 <qemu-stable@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v11 01/21] target/s390x: Fix wrong address handling in
 address loops
In-Reply-To: <a38386d1eb7c0809e62a4e3399f8ea0e@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260707161815.40919-1-freude@linux.ibm.com>
 <20260707161815.40919-2-freude@linux.ibm.com>
 <3e31b38c-0561-4f37-b2c4-97c10e6f232f@tls.msk.ru>
 <d5436f34-5489-4335-bf83-74b924e04140@tls.msk.ru>
 <a38386d1eb7c0809e62a4e3399f8ea0e@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Wed, 08 Jul 2026 16:16:04 +0200
Message-ID: <87zf01in2z.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21815-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:mjt@tls.msk.ru,m:richard.henderson@linaro.org,m:iii@linux.ibm.com,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:fcallies@linux.ibm.com,m:qemu-stable@nongnu.org,m:philmd@oss.qualcomm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cohuck@redhat.com,linux-s390@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cohuck@redhat.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9FF172751E

On Wed, Jul 08 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 2026-07-08 13:18, Michael Tokarev wrote:
>> On 08.07.2026 13:37, Michael Tokarev wrote:
>>> On 07.07.2026 19:17, Harald Freudenberger wrote:
>>>> The loop increments addr by the element stride (+=3D 4) before calling
>>>> wrap_address, but then overwrites the loop addr with the wrapped
>>>> value. On the next iteration the stride is applied to the wrapped
>>>> address of the previous element, not to the original unwrapped
>>>> address. This results in every element after the first is read from a
>>>> wrong (wrapped) address.
>>>>=20
>>>> Fixes: 9f17bfdab4 ("target/s390x: support SHA-512 extensions")
>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>> ---
>>>> =C2=A0 target/s390x/tcg/crypto_helper.c | 12 ++++--------
>>>> =C2=A0 1 file changed, 4 insertions(+), 8 deletions(-)
>>>=20
>>> This feels like qemu-stable material.
>>> I'm picking this change up for currently active stable qemu series.
>>> Please let me know if I shouldn't.
>>=20
>> Um, this was a bit premature.
>>=20
>> This particular commit requires a previous commit in this area,
>> de96db79 "target/s390x: Compile crypto_helper.c as common unit".
>> It's easy to back-port across, but since this change ("Fix wrong
>> address handling...") hasn't been marked as for-stable, I'm *not*
>> doing that.  If this change is actually needed in -stable, please
>> let me know.  Also, is it okay to pick up the previous change
>> ("compile as common unit") to -stable too, to avoid fixing up
>> subsequent changes.
>>=20
>> Thanks,
>>=20
>> /mjt
>
> Fine with me. However, Connie replied to my v10 series that she
> wants to pick this patch. However, it is yet not on the qemu
> master branch.

Should be now, as the s390 update was pulled?


