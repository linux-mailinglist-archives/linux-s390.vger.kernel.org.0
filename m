Return-Path: <linux-s390+bounces-20271-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFWqM3nQHGrYSwkAu9opvQ
	(envelope-from <linux-s390+bounces-20271-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 01 Jun 2026 02:21:13 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C673618748
	for <lists+linux-s390@lfdr.de>; Mon, 01 Jun 2026 02:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8B51301024F
	for <lists+linux-s390@lfdr.de>; Mon,  1 Jun 2026 00:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8D1A3029;
	Mon,  1 Jun 2026 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0P12n3Z"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097AD2BD0B
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780273263; cv=none; b=FECrbLKp/VD6eIUL00RZzLscElvzQrEIg/QuJrlWa18SH8dW2I+3bqjmYrlrcK/hrICvS4hHXvYivyVbtItoMY6UhW2f3QRWq8EU80T5Bns8eSwhyLNsxc15k4fFY84Cj//CfkvxSP/T1LBZg8Oo94OLaf0yKQcyVn4rxaGfw0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780273263; c=relaxed/simple;
	bh=y5x9VeqDKEmwkx8OrFdnevKo8r2xzK2tzc4l1QYQnSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXOUKoKkP2rk23uOgjkKga6VZEVLUrA9OG2yWK1nbzya1YMBocCcng7/aMhqOZSzHzF+qsQoXbVRKXA6bGndpRmuayf+QO9D9fByv7HC4HDkEVOs5R0gLazFWyDcWN91htud/vHIHDCrD0OqOQkyoM0yDK6cV8ZV/6Ew1Vz6tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0P12n3Z; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dee6b76a73so20676877b3.0
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 17:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780273261; x=1780878061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CM1q9ViEK2AU/qrAQZYqabaGPjGPWPy1MZYzvbR6QNs=;
        b=O0P12n3ZBVRRkXrRnz8YLYNNSxsPTZGzyUxGSaVk2qMgBQhHkNWq7QkvQ0LO6rSsZj
         0NmPKaKu36X5HdsL4MW8Hk4OKRoZahPa+WKMFtH3k0keaYIxsfderkwDZ3jcRf0Wn0KT
         njatsn6FWOD4ynP6MjwZMMYUa5gGBqzItpwhjCfr5Csx3241835NwNmD0UD3M5MiGC/S
         6PeK7dWzLLbBhFYCQbo/eMejyxvKMsPn8PCz80HL5UbXF8hJzWGnx0jgDuGdJSdkB9N9
         IuIAXlwRO1Jy3wvBzP3dEDubaHb7JP53uK+ItMAJpKWVjFBipq9D++RQvmsT8Wlb47Ej
         sqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780273261; x=1780878061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CM1q9ViEK2AU/qrAQZYqabaGPjGPWPy1MZYzvbR6QNs=;
        b=n9VNiVgh+GDibc0yIryT/nejiWqUlV3G9b1sY/tCvfmMob/LowXpqExn5ZRC5G4jXw
         ZIH9ic+NKElpibKwFOpKlxugFmjKBmpR8g9B/UcSVWlRMFlDoQr2XbG6ZIKmpNGIJU4D
         5GVRE/SDn5lN56jQ/tHMFsqMm3YFvsCV4fTyoK9wixFmgSI4aQKwUxdwPV6RySbKCpJf
         JcQBByGZ0gKY4ezJNvyG61sPYFWtRo2sd6MOtxiuFTJuhw0up5QBctcxvsqW0ixLPhR5
         Vt0vjCjrx7N2aeUHEIw4NWswVYAW3omsNCaz/lYBy6D6nzdu10PWjT74fL1JH7yAGfrf
         N93Q==
X-Forwarded-Encrypted: i=1; AFNElJ/RJ41mUlv3+ULxdVMsLMNYJGNGqwkEwnGHCdVBtnlsuweja4BeaXjiZTHB/pIbuSfoNlRfzck/9Lzm@vger.kernel.org
X-Gm-Message-State: AOJu0YwnredAP12krtB7qipI75avv6iNDe5vmjP/UWzsl0pv9HAXQz57
	CQM4KfYMTIJunnhPS/QLSkCRQ8eA1Z+K9Ym/1SND3rQ5hOmzGC/mNU2n
X-Gm-Gg: Acq92OHQjIyQejDuLhTwKzKUfaA2kNAIc7PpLzDFXlEcTRaorbYrqJecz/bD2rjnFe7
	KLc9imtAIWSti8Qfa2q5DnLTmIGzufaR/iYzM3/DGgCqp/45rHtYL7wB73WPHbImVf4HhWKW/qG
	6UnLJ81tZoaq2i4mZyOmDNZndKO1Novxjmd2dVMNTjvPRt+xLqUlIE2qd3KNM7cIGdCV5GUZ06t
	VkcQFyBO/JC11xiNK3hSjm94x6TrkaXbhWkN7S4sg0/HVgQOiQFeZT6B+iVGOuGYcKpYKMFLJmF
	rCZ8wQuY9tO0lQeMSJiE9Zxc0VXw+RXCt+zuRD5GJjeQrfFtrmEVJwDMJxhpRmsrO+ppYhV3+xZ
	R8Zy51FB4/HkwJm7Z369C2Hy5/PnTlUgRQ2aGgBOgjDX01QyR8i2bU2LPBc/hEcRVXhJPbKi3zG
	Nl2QTsWyN58DZNx+AYWsZoLijO1hV3TlSQ748Whpmbv1IH9UIVK7WK
X-Received: by 2002:a05:690c:6d86:b0:7bd:7e01:8d89 with SMTP id 00721157ae682-7e05c47bda8mr77291477b3.24.1780273261126;
        Sun, 31 May 2026 17:21:01 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7e17bf00ff8sm30648267b3.37.2026.05.31.17.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 17:21:00 -0700 (PDT)
Date: Sun, 31 May 2026 17:20:54 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Wen Gu <guwen@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>,
	tglx@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jstultz@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	daniel.lezcano@kernel.org, sboyd@kernel.org,
	vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	yangbo.lu@nxp.com, svens@linux.ibm.com, nick.shi@broadcom.com,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
	imx@lists.linux.dev, linux-s390@vger.kernel.org,
	dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
	mani@kernel.org, imran.shaik@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
Message-ID: <ahzQZg_v4bxFfGdj@hoboy.vegasvil.org>
References: <20260407104802.34429-1-guwen@linux.alibaba.com>
 <20260407104802.34429-3-guwen@linux.alibaba.com>
 <20260412084704.743482ad@kernel.org>
 <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
 <20260412095301.4fe1fe65@kernel.org>
 <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
 <1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20271-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,linutronix.de,nxp.com,gmail.com,linux.dev,linux.ibm.com,broadcom.com,lists.linux.dev,oss.qualcomm.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardcochran@gmail.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:url]
X-Rspamd-Queue-Id: 8C673618748
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 06:06:32PM +0100, David Woodhouse wrote:

> Apologies for the delay. I have set up
> 
> https://git.infradead.org/?p=linux-ptp.git
> git://git.infradead.org/linux-ptp.git
> 
> But I'm not keen on using it without Richard's explicit approval and a
> clear understanding of who owns what, *and* the taxonomy we use...

The name "linux-ptp" is very close to "linuxptp" which is the user
space PTP stack.  So it is a bit confusing.

Thanks,
Richard



