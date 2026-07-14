Return-Path: <linux-s390+bounces-22260-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UrdBNtlEVmox2gAAu9opvQ
	(envelope-from <linux-s390+bounces-22260-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:16:57 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE6755A8C
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:16:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Hwrxz3xR;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22260-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-22260-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09F75300608D
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1153E360EF7;
	Tue, 14 Jul 2026 14:16:52 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A929BDBB
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:16:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038612; cv=none; b=RnKeijujVMm7ws0y87mD4z9pTLKP1YyEzTkiDkZ03TuuudYUeudsV551xGivC2lo/r28WwW9Evu5qJESAcZv7t2dwfVjfWHmdB7IC9UtNc/19Rahec8wUpyvXl1z8zPx54GHPFO+NWZeRoZYzSJPTHqyXZcmvDLlfYEujP2vpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038612; c=relaxed/simple;
	bh=gHVw0cBIJKycbq1rGwYH0QLiqdczFqjpZltO8qDkwzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aylIQTOcq40hBvM5gG9NsM/Q73VPL+A0lCNENz5RTwMowsyz8vNO97K1DpDz12RkyVSuxwvDB7M6xgq0DDoSumD+Q9ZUV8xnaWyvbGO866C9eMpP967uJPoK4o4NTTsHI5v2r3pjqfkXrA72gjf7Dvs5MWt7d08cB7mF1INZhiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hwrxz3xR; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784038609;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSjvs6rJvMUrMM1YGxxPDKDn1Jwp5ESxUXKK0qLqD0w=;
	b=Hwrxz3xRNwrVxw4+Wvv1J/qENZhlYupVWLfNgKj/5deravAdYpTQ+yRo2TRa6+8nH1QYS8
	JAcBoOser4Gtx+Kx6sakKBq5XnOhC4hw4h4crowm/i3AztGqsvIHO7tJSZJW2aeRm4zNZ6
	KXZwWRCJPTUWlILSej6WFFUA4xqKJ10=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-tW77gdX2M4KDKllxaQ6qyw-1; Tue,
 14 Jul 2026 10:16:41 -0400
X-MC-Unique: tW77gdX2M4KDKllxaQ6qyw-1
X-Mimecast-MFC-AGG-ID: tW77gdX2M4KDKllxaQ6qyw_1784038592
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0876F197768D;
	Tue, 14 Jul 2026 14:16:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.163])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CADB936918;
	Tue, 14 Jul 2026 14:16:12 +0000 (UTC)
Date: Tue, 14 Jul 2026 15:16:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
	thuth@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
	linux-s390@vger.kernel.org, dengler@linux.ibm.com,
	borntraeger@linux.ibm.com, fcallies@linux.ibm.com,
	cohuck@redhat.com
Subject: Re: [PATCH v12 04/17] crypto: Add aes-helpers file to support some
 AES modes
Message-ID: <alZEqU-d7NTHI1ZF@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260710152906.80207-1-freude@linux.ibm.com>
 <20260710152906.80207-5-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710152906.80207-5-freude@linux.ibm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pixelfed.art:url,berrange.com:url,libvirt.org:url];
	TAGGED_FROM(0.00)[bounces-22260-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:richard.henderson@linaro.org,m:iii@linux.ibm.com,m:david@kernel.org,m:thuth@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:fcallies@linux.ibm.com,m:cohuck@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[berrange@redhat.com,linux-s390@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[berrange@redhat.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[berrange@redhat.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9EE6755A8C

On Fri, Jul 10, 2026 at 05:28:50PM +0200, Harald Freudenberger wrote:
> Add a new file crypto/aes-helpers.c with simple functions
> to support some AES modes:
> - AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
> - AES ctr: AES_ctr_encrypt()
> - AES xts: AES_xts_encrypt() AES_xts_decrypt()
> and some AES related helpers:
> - AES_xor()
> - AES_xts_prep_next_tweak()
> Add header file include/crypto/aes-helpers.h for these functions
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>  crypto/aes-helpers.c         | 106 ++++++++++++++++++++++++++++++++
>  crypto/meson.build           |   1 +
>  include/crypto/aes-helpers.h | 116 +++++++++++++++++++++++++++++++++++
>  3 files changed, 223 insertions(+)
>  create mode 100644 crypto/aes-helpers.c
>  create mode 100644 include/crypto/aes-helpers.h

> diff --git a/include/crypto/aes-helpers.h b/include/crypto/aes-helpers.h
> new file mode 100644
> index 0000000000..c1552b0e8f
> --- /dev/null
> +++ b/include/crypto/aes-helpers.h
> @@ -0,0 +1,116 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * AES helper functions and modes
> + */
> +
> +#ifndef QEMU_AES_HELPERS_H
> +#define QEMU_AES_HELPERS_H
> +
> +/**
> + * AES_xor:
> + *
> + * Bitwise XOR operation between two AES blocks.
> + *
> + * @src1: first source buffer of AES_BLOCK_SIZE bytes
> + * @src2: second source buffer of AES_BLOCK_SIZE bytes
> + * @dst: destination buffer of AES_BLOCK_SIZE bytes

nit-picking - the list of parameters should normally be at the
start of the docs comment, immediately after the function name,
and then the description follows

With that change made:

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
  Acked-by: Daniel P. Berrangé <berrange@redhat.com>



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


