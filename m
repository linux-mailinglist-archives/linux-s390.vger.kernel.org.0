Return-Path: <linux-s390+bounces-3100-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48B89A98F
	for <lists+linux-s390@lfdr.de>; Sat,  6 Apr 2024 09:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A4E1F223FB
	for <lists+linux-s390@lfdr.de>; Sat,  6 Apr 2024 07:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5347D225CF;
	Sat,  6 Apr 2024 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VONH2XnX"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D42200BF
	for <linux-s390@vger.kernel.org>; Sat,  6 Apr 2024 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712388612; cv=none; b=g1Sgwzcy1d6EVq37c3/lNSgGXi1ogKT4GmenVbU1Homabc7UXkJnpurJI+r1RtDBioQaKT0IgyQ0qMc07eqYm5QrVeDYe/FH0EC+hkvZiDiVRwJTi/w0psjoG0idNmfvbBCTKNrxyY4k2FbUFzWJR/yn7Ig16bOx3nuBxShy4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712388612; c=relaxed/simple;
	bh=EiOLesEbfUDQbQH025YsSHxrXoch1GdDr36PdIuC1wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWrHsSw1snmw0llzcllteHZ/3WIn6O7ZO9WyXV44HEsd7migY11/FiikfIT+dlsOrs0tm15xEKIo3m1k7q665/1sKlNzBrNn1kWEFYeC0lsdrdwE6WcMN1QBI2nGptMQqeTxlL4TmuxGhNzUI0NweeeqNc0mLIZ0obE2pD+1ET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VONH2XnX; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 6 Apr 2024 09:30:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712388606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4VClCDgGsrOijiN2aMuip12kqj4B5e5rGZ9WIheBfg=;
	b=VONH2XnXTurq1b4ktKNCxBCYal3GcE+yz2Vucv9y8WMdGgAoCYzXy9UIQLEhU6F34EvLlj
	I5b4rHwGMUffE4y9iieUdna92U3I+99Gm+PVEdC6cnunBUuVjA3DGaQE7eBlJwCB/IYXlX
	A7k5tuLcKoavDA4/Ajjrx2yOimRyFr8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Eric Auger <eric.auger@redhat.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Nico =?utf-8?B?QsO2aHI=?= <nrb@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Nikos Nikoleris <nikos.nikoleris@arm.com>, 
	Nadav Amit <namit@vmware.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Ricardo Koller <ricarkol@google.com>, rminmin <renmm6@chinaunicom.cn>, Gavin Shan <gshan@redhat.com>, 
	Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests RFC PATCH 17/17] shellcheck: Suppress various
 messages
Message-ID: <20240406-35a566d73057343e596e0fc9@orel>
References: <20240405090052.375599-1-npiggin@gmail.com>
 <20240405090052.375599-18-npiggin@gmail.com>
 <20240405-7c0ad5d3ce76e1ad9ad2f5a9@orel>
 <D0CTUKHP4IZV.2OQZNUD6J9U1P@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0CTUKHP4IZV.2OQZNUD6J9U1P@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 06, 2024 at 04:31:17PM +1000, Nicholas Piggin wrote:
...
> > > diff --git a/scripts/runtime.bash b/scripts/runtime.bash
> > > index 3b76aec9e..c87613b96 100644
> > > --- a/scripts/runtime.bash
> > > +++ b/scripts/runtime.bash
> > > @@ -137,6 +137,8 @@ function run()
> > >      # the check line can contain multiple files to check separated by a space
> > >      # but each check parameter needs to be of the form <path>=<value>
> > >      if [ "$check" ]; then
> > > +        # There is no globbing allowed in the check parameter.
> > > +        # shellcheck disable=SC2206
> > >          check=($check)
> >
> > Hmm, I'm not sure about this one. $check is an arbitrary path, which means
> > it can have spaces, then =, and then an arbitrary value, which means it can
> > contain spaces. If there are multiple check path=value pairs then
> > separation by space is a bad idea, and any deliminator really is. It seems
> > like each pair should be quoted, i.e.
> >
> >  check = "path1=value1" "path2=value2"
> >
> > and then that should be managed here.
> 
> Yeah I did think of that, valid paths could also have = and ", and even
> with double quotes it seems to be tricky to handle spaces.
> 
> Maybe I'll just add to the unittest.cfg docs to stick with alphanumeric
> paths, and we can improve it if someone complains?

Works for me.

Thanks,
drew

