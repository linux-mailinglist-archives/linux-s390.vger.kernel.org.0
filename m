Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BD2F8C0F
	for <lists+linux-s390@lfdr.de>; Tue, 12 Nov 2019 10:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfKLJlX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 12 Nov 2019 04:41:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29763 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbfKLJlX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Nov 2019 04:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573551682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kamQbVxJE5ElqqCSYGnRo/PaqtEy27FbLwc20ZuKZqQ=;
        b=TpEVgbqRJGd0VpwCepLXzGKrZf/zOHJY/+YKq6v6g9kxmBFZz6b5c6xyQhIdxNb3wcyj22
        lHMzRiOLme/QgGYdoOWQAz7si7cKQO/qTInv1QpIZYjtcdHl2yNFulDRB852lx9vR7TKVu
        O0kk24nPsU7+At8SOCBNw4WZaCOWOY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-z0ViwiboO-yikvZ1tuu_ew-1; Tue, 12 Nov 2019 04:41:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25F539F481;
        Tue, 12 Nov 2019 09:41:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-124.ams2.redhat.com [10.36.116.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2944363BA9;
        Tue, 12 Nov 2019 09:41:16 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v2 2/3] s390x: Add CR save area
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, david@redhat.com
References: <20191111153345.22505-1-frankja@linux.ibm.com>
 <20191111153345.22505-3-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <b57dc6f5-76ba-8d7b-cae1-0437cfe410ab@redhat.com>
Date:   Tue, 12 Nov 2019 10:41:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191111153345.22505-3-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: z0ViwiboO-yikvZ1tuu_ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/11/2019 16.33, Janosch Frank wrote:
> If we run with DAT enabled and do a reset, we need to save the CRs to
> backup our ASCEs on a diag308 for example.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm-offsets.c  |  2 +-
>  lib/s390x/asm/arch_def.h |  4 ++--
>  lib/s390x/interrupt.c    |  4 ++--
>  lib/s390x/smp.c          |  2 +-
>  s390x/cstart64.S         | 10 +++++-----
>  5 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

