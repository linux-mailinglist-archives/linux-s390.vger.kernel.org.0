Return-Path: <linux-s390+bounces-19645-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFz9LUGeBGr3LwIAu9opvQ
	(envelope-from <linux-s390+bounces-19645-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 13 May 2026 17:52:33 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 982D1536871
	for <lists+linux-s390@lfdr.de>; Wed, 13 May 2026 17:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F6BE313110E
	for <lists+linux-s390@lfdr.de>; Wed, 13 May 2026 15:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D781496910;
	Wed, 13 May 2026 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9lgWWYJ"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005F47B406
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686255; cv=none; b=l9VEDLwFBiIuCO6NeZk7xyeShccG1IgH3FRF//c24jIrdCqJqsITBLqrNkQtOVfJ+61lS8fJHC97zGGmsw8+meO5HgbYeOGMzIHwEbV+hmcgWh84TErKKzbhmitWO5fhr0qbeboCChUO4FaCIM7fK5B6i077M9tETeU1Io4tWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686255; c=relaxed/simple;
	bh=mbuD0JF9KaUEuPIUs6xAsmmDkMJ/Km6xGJoIuowhhZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICfXwPbkQ+3aLOwpfWH0va8xRZjMORtHRcJUVML5AcDqklbdxP+hR0PSHKZFWzYBl8ArIWZo9GujwB14uTLRPEMZyfjvUjerCIoDIRPKcdXJZWLmbMFc++uAhT8FC6wG4HV3as6bedioezfohRm+D187a0J6Z0Z0YbTHsIzWqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9lgWWYJ; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-3667cf0136fso5157233a91.2
        for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 08:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686253; x=1779291053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WEkxdb5zhixaN862xcykga1EtiV0FhFLsCrfHJvXPCk=;
        b=A9lgWWYJz8SsdDXQcuks5hSiwua4TwQ57+MERJGv+1wSGHqiDnillQHdQWiesl0wSz
         ukN/lZW33ZjcgHL1cSPcqubzLFGDFg16kewwnXMHYETxpX4DWyIkqIKSQ95ku9/Vd9Z9
         1WKbZbfHf+OHHSxN2W3SQG9ENGB9y9HlwBPZQeT/ixJu1FCmd62KxatTUxS07TMpll9m
         VYgBlUybt2BK/JuyCGkSLRdgipUp7DTjIV5jPd0d/KytGFGp12UrGrljj9AKvMV1yv6y
         AARG7OfRTn/RlMW2wVdVVi7vWAwLH2QgBUO8s7+TzVCR09yPoIF1OUWrTuSXuubKQO+b
         jSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686253; x=1779291053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEkxdb5zhixaN862xcykga1EtiV0FhFLsCrfHJvXPCk=;
        b=AvT/F5pGkrXUs2WyDDBvtqx8Jj8M7P0EPCbhv9XYZc4WuB3n+wlV1vfG2qY7X5CCAR
         J0n6kuJbhF/h6zKnDeHMuI64KxXHnkG28JnwXnjNzwD+xnyptshsGPMYYjpU9R93TnJz
         OynNmyWGjSpAX613RoHtC1fLW28+ORtLP6tVmLb9iRpzNgkPQ0CgTbd6buXJTOP6emUU
         YekUO36axZ+fnRQetsELxDwaXZ02ws72rzW575khG5joKr9KLURrRCkRl87ED2XAIdl7
         fHLBUOJoXcCNZse2Gxloj/WMuIRgshadRrc5eT7cYcgVLRbVbsN+U5jKe93Z05ag107S
         cpKg==
X-Forwarded-Encrypted: i=1; AFNElJ/3S64I+2kYDQ+u97pqFyp2Vly1evYac7e7UMbDZhq2kWHvOUiUOQoVDK1YoZX3YacmqoHTeuif7tZS@vger.kernel.org
X-Gm-Message-State: AOJu0YwbH5VltUeduamgj4I5ByAJlILHw4kGNShK+bjSh5P1aTNkLHF/
	FeL5Z9KACbyjv0BJC6dWBVp6tSZUFDJgM7fhAGi1Kg7910AD9Uj/Y46D
X-Gm-Gg: Acq92OEjcmph50bvLacf9BefJAI+UIQJODJdEA8w5JbFCB0c0JVyH0MQ/mDU7SNkTig
	tsWKzOoVDLkEiI3D+YggpSA788k2dXZSp+wJiKYGWqa9W6xCcqq/8QJWckajXwzUgb2Na0VPG+G
	T2TwusVJBH5KhSUpCKwDX2BrnQ+OfYcdh5X4HNvVjrIl/4XZz+24Q6seYObYY6M/bSTUyHc8uzK
	xJTxfCzEA3Fyc0aZQ81PNYu+2eIpbxQSajwi5DYHZnTpPcU9KGuGlR7K1vuHR+C2/S1OzzziLd+
	x9rTHJx+i/QE+Bs/2lRxcLGA96zuOBUzsTLwp9/hpO7Y/P6OvaXKsMgD4ccxRs+Nm810BYkXiqP
	lmiX/hgKxGQbOIujR3NJyqZLJ3p137vDHI1zJdrR0q59beQcOlocYce1pD0fO1prX6T3l9K5fA8
	y+8lBQoBLkkSACdIvi
X-Received: by 2002:a17:90a:f946:b0:364:e97f:64e7 with SMTP id 98e67ed59e1d1-368f3e69a23mr4490008a91.27.1778686252746;
        Wed, 13 May 2026 08:30:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf4d95bsm4782439a91.6.2026.05.13.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:30:52 -0700 (PDT)
Date: Wed, 13 May 2026 08:30:51 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 3/6] af_iucv: convert to getsockopt_iter
Message-ID: <agSZI50mjW_1q5ia@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-3-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-3-fe7f0e756fac@debian.org>
X-Rspamd-Queue-Id: 982D1536871
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19645-lists,linux-s390=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,intel.com,fomichev.me,iogearbox.net,linux.ibm.com,katalix.com,auristor.com,ixit.cz,linux.intel.com,lists.sourceforge.net,vger.kernel.org,lists.infradead.org,lists.linux.dev,meta.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390,nfc];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm7509.cco0.facebook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Action: no action

On 05/13, Breno Leitao wrote:
> Convert IUCV socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

