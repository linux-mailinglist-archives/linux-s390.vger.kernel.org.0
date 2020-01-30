Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B147514DEF6
	for <lists+linux-s390@lfdr.de>; Thu, 30 Jan 2020 17:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgA3QXK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 30 Jan 2020 11:23:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27688 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727193AbgA3QXJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jan 2020 11:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580401389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJSQD3AXl/EaZ99zNfwoAQo1e7uugD5rp6Es/BTAolQ=;
        b=a1w9F0wHdX0FROhyErY4Is+/tdoE0FQklxzuokFG0Wt88Qcn2lom/uBVk9YYMDHhgD/Zkh
        2Sv9rt9zmHPNdy08xOKZ5WqeOBmGmsRlS6DYrVi/0pQMesJJlTIwfKmTpegH0N8r61pTJn
        zddtyYxx6d2JnQ1YUvjJLKn5Tbd/GgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-usqeU-CpOr2p3w_KRa8z-w-1; Thu, 30 Jan 2020 11:23:04 -0500
X-MC-Unique: usqeU-CpOr2p3w_KRa8z-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2595800D41;
        Thu, 30 Jan 2020 16:23:03 +0000 (UTC)
Received: from gondolin (ovpn-117-199.ams2.redhat.com [10.36.117.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9733A77921;
        Thu, 30 Jan 2020 16:22:57 +0000 (UTC)
Date:   Thu, 30 Jan 2020 17:22:55 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com,
        david@redhat.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v9 5/6] selftests: KVM: s390x: Add reset tests
Message-ID: <20200130172255.4b38c058.cohuck@redhat.com>
In-Reply-To: <20200130123434.68129-6-frankja@linux.ibm.com>
References: <20200130123434.68129-1-frankja@linux.ibm.com>
        <20200130123434.68129-6-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 30 Jan 2020 07:34:33 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Test if the registers end up having the correct values after a normal,
> initial and clear reset.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/Makefile       |   1 +
>  tools/testing/selftests/kvm/s390x/resets.c | 157 +++++++++++++++++++++
>  2 files changed, 158 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/resets.c

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

