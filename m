Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C702D2DFD
	for <lists+linux-s390@lfdr.de>; Tue,  8 Dec 2020 16:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgLHPQ2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 8 Dec 2020 10:16:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729927AbgLHPQ2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Dec 2020 10:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607440502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lk9iLrarB0PA2siXRHstRF3YG5ne7QRdfDHcMgs2VS4=;
        b=IGbX35D12AxBsIsYa5LV0jEH7jFFQN0C3iKdMYmiyOQwwvpbh0jSNXKoVMJEMe5DCNSzoa
        vJo0h3sExXMG0FmxhLf7dveiAQ9zCqsn5yV6UtN3FTXEBavTR6ULRx1CoXoA+kp3b9tTyb
        u1WznkikMk58tcuQFVuiJrd9LojmfTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-526AZLe6NW2_EgDnun-9TA-1; Tue, 08 Dec 2020 10:15:00 -0500
X-MC-Unique: 526AZLe6NW2_EgDnun-9TA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79F65809DDB;
        Tue,  8 Dec 2020 15:14:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-38.ams2.redhat.com [10.36.112.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6C891042A79;
        Tue,  8 Dec 2020 15:14:51 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH 1/2] s390x: Move to GPL 2 and SPDX license
 identifiers
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org
References: <20201208150902.32383-1-frankja@linux.ibm.com>
 <20201208150902.32383-2-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <ba6a2c95-480e-a870-a5ba-7f54f55c4488@redhat.com>
Date:   Tue, 8 Dec 2020 16:14:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201208150902.32383-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08/12/2020 16.09, Janosch Frank wrote:
> In the past we had some issues when developers wanted to use code
> snippets or constants from the kernel in a test or in the library. To
> remedy that the s390x maintainers decided to move all files to GPL
> 2 (if possible).
> 
> At the same time let's move to SPDX identifiers as they are much nicer
> to read.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/cmm.c       | 4 +---
>  s390x/cpumodel.c  | 4 +---
>  s390x/css.c       | 4 +---
>  s390x/cstart64.S  | 4 +---
>  s390x/diag10.c    | 4 +---
>  s390x/diag288.c   | 4 +---
>  s390x/diag308.c   | 5 +----
>  s390x/emulator.c  | 4 +---
>  s390x/gs.c        | 4 +---
>  s390x/iep.c       | 4 +---
>  s390x/intercept.c | 4 +---
>  s390x/pfmf.c      | 4 +---
>  s390x/sclp.c      | 4 +---
>  s390x/selftest.c  | 4 +---
>  s390x/skey.c      | 4 +---
>  s390x/skrf.c      | 4 +---
>  s390x/smp.c       | 4 +---
>  s390x/sthyi.c     | 4 +---
>  s390x/sthyi.h     | 4 +---
>  s390x/stsi.c      | 4 +---
>  s390x/uv-guest.c  | 4 +---
>  s390x/vector.c    | 4 +---
>  22 files changed, 22 insertions(+), 67 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

