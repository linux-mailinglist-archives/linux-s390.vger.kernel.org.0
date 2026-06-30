Return-Path: <linux-s390+bounces-21363-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rs3zG/PDQ2qKhAoAu9opvQ
	(envelope-from <linux-s390+bounces-21363-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 15:26:11 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6B26E4D32
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 15:26:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=iZUwlxYf;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21363-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21363-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56DA130C7B8B
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C14E41C313;
	Tue, 30 Jun 2026 13:22:00 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB329413D69
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 13:21:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825720; cv=none; b=IHU9nYQQbXinUizy3UyMepTN6sy02+T+fHHMMieFZ9AkCStJX5cRvdumxcRzbVyyqSyvlu2DP0S9Hercz69Iu54rOZ6oBZuLFe47GiTFdvc7lLK3MD2BoIBzYuK3v9/pUiGfOTmipk9kYhYl1g0ruy6/yHgGJ8lB/g01EHRs3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825720; c=relaxed/simple;
	bh=fvvCtgRg2vwFmeJK+BSLf33yAtiofR7jA0bQsJGULQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M33ayV/yHTsx/uJpFAOnFYFmQShgbDMBwe/lhJ/2y2nNCh3MWl7v4q/LpPlJb0N23gurZb/k5B5lFl9uuNW/G6mblokLz8NnArx3gH8g5hAq3cUJwJXSOdaeGJ6mL4bhebsYHwWJK+ArryOmfgzcX/1ikzhRIxEE0TZYaRcd3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZUwlxYf; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782825718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=id6Gn72flvltTtLNae1NVFOonek88cQ4TW8gPOjfsjY=;
	b=iZUwlxYfbeRuT49MnhqB7ICQ07D/aL9DSnCQZMSbvwN2GVXUoODrftQzDKSaETedoQDyrk
	7Vo2+8Swaf0pS/Pv+sLlgLaes4ag3ez08ZJwGtor1zjiKqZjv1CScKvVaRjX241GdSwvJP
	kqRLoRTMRuhlSusqEeJayA3AOfRhcUA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-USCyT9AgNUyJnVoqc8Mr2Q-1; Tue,
 30 Jun 2026 09:21:54 -0400
X-MC-Unique: USCyT9AgNUyJnVoqc8Mr2Q-1
X-Mimecast-MFC-AGG-ID: USCyT9AgNUyJnVoqc8Mr2Q_1782825713
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D57E71955D5A;
	Tue, 30 Jun 2026 13:21:52 +0000 (UTC)
Received: from localhost (unknown [10.44.34.134])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23217364F7;
	Tue, 30 Jun 2026 13:21:51 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Nico
 =?utf-8?Q?B=C3=B6hr?= <nrb@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>
Subject: Re: [PATCH] s390x: stsi: regression test for the STSI 3.2.2 count
 clamp
In-Reply-To: <20260629091921.710920-1-borntraeger@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260629091921.710920-1-borntraeger@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 30 Jun 2026 15:21:49 +0200
Message-ID: <87ik70kvte.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21363-lists,linux-s390=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:borntraeger@linux.ibm.com,m:frankja@linux.ibm.com,m:imbrenda@linux.ibm.com,m:nrb@linux.ibm.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[cohuck@redhat.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cohuck@redhat.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C6B26E4D32

On Mon, Jun 29 2026, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> See https://lore.kernel.org/qemu-devel/20260622092035.400959-1-borntraeger@linux.ibm.com/
> for the QEMU fix.

Could now also refer to QEMU commit a57e4612b61d ("s390x/kvm: clamp stsi
3.2.2 size") directly.

> Add a regression test that races STSI 3.2.2 on one CPU against a second CPU
> that continuously forces an out-of-range count value.
> The out of bound access usually crashes/asserts QEMU with any sane
> distribution build of QEMU, so its more or less guest root can kill itself.
> We should test and fix nevertheless.
> Testcase piggybacks on the existing stsi test, so some cases will be
> tested twice. (with smp 1 and smp 2)
>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> ---
> If wanted we could split this into a separate file or always run the
> test with smp=2 to avoid the duplication

I think it's reasonable to keep this with the other STSI tests.

>
>  s390x/stsi.c        | 76 ++++++++++++++++++++++++++++++++++++++++++++-
>  s390x/unittests.cfg |  9 ++++++
>  2 files changed, 84 insertions(+), 1 deletion(-)
>

FWIW,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


