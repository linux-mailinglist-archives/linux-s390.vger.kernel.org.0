Return-Path: <linux-s390+bounces-3781-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397798B96FA
	for <lists+linux-s390@lfdr.de>; Thu,  2 May 2024 10:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE790280D4F
	for <lists+linux-s390@lfdr.de>; Thu,  2 May 2024 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C141F4D5BD;
	Thu,  2 May 2024 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qQtVI3Pp"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9134C25634
	for <linux-s390@vger.kernel.org>; Thu,  2 May 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640215; cv=none; b=D9HcdzH0CdIW2GAoHv9uPsWj4Ks0aJsoL8qZVwQcNRnxpQaN/xto42PInp3tBqG4utkcUbgw3x2X55fZaYPF/EBL5TZ4igSIUXX6xDt8ZjX3W4yq/tKGEnfnuqJ7e59ukkm1b5GJ9wU2mGEXp3CHT3Yq0loRfifJZulTw+BiX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640215; c=relaxed/simple;
	bh=I6bMyw1jF1AgZCJ2Fg0wDJbU7dp25u9F1kopuE9sFKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/z3axwg0OBEVePVaxXbR5UrpFNh3wU/wk+uWZRREapzsF6eVWWFd1VzFSzvq8jGUp3wTR93hYcTbu1XWWBfFt2i+x95mtSJ9Dk/EXU0arKr916AanTmwxVy6ESBLcwKhI6mrFNOrIMzYRlOo5JGyzgoDlAnP92fsZEHHRXWtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qQtVI3Pp; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 2 May 2024 10:56:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714640211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b3E99RjdsZuW6QIhdK1veF7oJEr4cvXdyWQVuiOrXTI=;
	b=qQtVI3PpQ2HmV/+9zZO62OgQ5OLjMqEGLyqwPKn7TiOalOfN+i7Q/qu3NOC/OhoRAPNO9j
	g8S05KIUkQD7Ojt2ask946ZMBzT/aifKDYNCcFLO2CWGJAN9OaQWZ/bn4gWkEsjTQvlYNZ
	pEkU1KKu3+OOhH/kDZaSGzm9O21u/E4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Eric Auger <eric.auger@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Nico =?utf-8?B?QsO2aHI=?= <nrb@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Nikos Nikoleris <nikos.nikoleris@arm.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Ricardo Koller <ricarkol@google.com>, rminmin <renmm6@chinaunicom.cn>, Gavin Shan <gshan@redhat.com>, 
	Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v3 0/5] add shellcheck support
Message-ID: <20240502-d231f770256b3ed812eb4246@orel>
References: <20240501112938.931452-1-npiggin@gmail.com>
 <2be99a78-878c-4819-8c42-1b795019af2f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2be99a78-878c-4819-8c42-1b795019af2f@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 02, 2024 at 10:23:22AM GMT, Thomas Huth wrote:
> On 01/05/2024 13.29, Nicholas Piggin wrote:
> > This is based on upstream directly now, not ahead of the powerpc
> > series.
> 
> Thanks! ... maybe you could also rebase the powerpc series on this now? (I
> haven't forgotten about it, just did not find enough spare time for more
> reviewing yet)
> 
> > Since v2:
> > - Rebased to upstream with some patches merged.
> > - Just a few comment typos and small issues (e.g., quoting
> >    `make shellcheck` in docs) that people picked up from the
> >    last round.
> 
> When I now run "make shellcheck", I'm still getting an error:
> 
> In config.mak line 16:
> AR=ar
> ^-- SC2209 (warning): Use var=$(command) to assign output (or quote to
> assign string).

I didn't see this one when testing. I have shellcheck version 0.9.0.

> 
> Not sure why it's complaining about "ar" but not about the other lines in there?
> 
> Also, it only seems to work for in-tree builds. If I run it from an
> out-of-tree build directory, I get:
> 
> */efi/run: */efi/run: openBinaryFile: does not exist (No such file or directory)

I'm glad you checked this. I wish I had before merging :-/

Thanks,
drew

