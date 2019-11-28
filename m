Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FE010CEF7
	for <lists+linux-s390@lfdr.de>; Thu, 28 Nov 2019 20:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK1TsG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 28 Nov 2019 14:48:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39654 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726401AbfK1TsG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 28 Nov 2019 14:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574970485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvPlK3FY9i9H+9TL/UAhr/vwa8L3atPNKvm4SjuaV3w=;
        b=dIIQnWuE6HNUm2UagOVkavuyVtPHpeU6vVBAI73MpPkwHgBJaecxeEfUlqWB6TKacEdoZj
        bPkHwOIv7bDAQ4+FUchkSSOF2LLDHMgYGXUeJMTa8OYItGjH/3LTazW2NTqc+e0eXZQBV3
        VBJbk2CwMWi+TJau0j5wmbC4ztbQbIs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-ZbqHc7fEOxSKhU8vFzNTSw-1; Thu, 28 Nov 2019 14:48:04 -0500
Received: by mail-wr1-f70.google.com with SMTP id y1so14400344wrl.0
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 11:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=YvPlK3FY9i9H+9TL/UAhr/vwa8L3atPNKvm4SjuaV3w=;
        b=r8f7jFnA30tHM2LWkO6ZaYohndC1O+biJyqKNoK2Vt8TV8WIZ9QOkdPo+I7D1qte54
         dC1Uo7nrxwkN0oTg4aW+3MJImsTLqS3cjWPe5/hXlB2MYs/C2oHn0I8UvbODHTiOl/A/
         QqJ3siDTDytQpm0T1QOteQWywt7L4harKm/iC6VF9PG9lzUQOyb8JFffhhCPbMiz04y0
         +2QuchJyCUd9pFFkX32L8myp/7H852Sg+x7haaKe4hAjqk+hUOJGKYfVP2YcLkoO6djo
         wOmolgTqugbPDZ7B2saUUoRWJHHsuAAZMaHLFhU1J0kVDOzNiUbrGw9syTLta5O11zD/
         MS7g==
X-Gm-Message-State: APjAAAVqlSPzF45R5Yjkh8EZIHEvfTthICYWon2aKktCTy21Eahp5d3g
        7P1XGg2CH4OYihsmmVhMcrvezLNSDnNo/yZHYUuO+xpk16gk9NKItjmth1D72SffQVCTbl210pK
        xApIlMrtXMCrYnFsCI63QRw==
X-Received: by 2002:a5d:6048:: with SMTP id j8mr13791681wrt.41.1574970483646;
        Thu, 28 Nov 2019 11:48:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyy8wMkFJhMkD+2MNkZuc7gOpe6rl3TIYCocJrmP0KBpHq6nlsnOURLQwVa6Ah+CifS9sUkNA==
X-Received: by 2002:a5d:6048:: with SMTP id j8mr13791671wrt.41.1574970483494;
        Thu, 28 Nov 2019 11:48:03 -0800 (PST)
Received: from [192.168.3.122] (p5B0C6369.dip0.t-ipconnect.de. [91.12.99.105])
        by smtp.gmail.com with ESMTPSA id h140sm11725884wme.22.2019.11.28.11.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 11:48:02 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [kvm-unit-tests PATCH v2 2/9] s390x: Define the PSW bits
Date:   Thu, 28 Nov 2019 20:48:00 +0100
Message-Id: <30DD27E7-BE6E-4986-AD69-7718E6B9A730@redhat.com>
References: <7abb4725-b814-8b43-8a4f-e0e2cf7a44f8@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        thuth@redhat.com, cohuck@redhat.com
In-Reply-To: <7abb4725-b814-8b43-8a4f-e0e2cf7a44f8@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: ZbqHc7fEOxSKhU8vFzNTSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



> Am 28.11.2019 um 20:16 schrieb Pierre Morel <pmorel@linux.ibm.com>:
>=20
> =EF=BB=BF
>> On 2019-11-28 15:36, David Hildenbrand wrote:
>>> On 28.11.19 13:46, Pierre Morel wrote:
>>> Let's define the PSW bits  explicitly, it will clarify their
>>> usage.
>>>=20
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>  lib/s390x/asm/arch_bits.h | 20 ++++++++++++++++++++
>>>  lib/s390x/asm/arch_def.h  |  6 ++----
>> I'm sorry, but I don't really see a reason to move these 4/5 defines to
>> a separate header. Can you just keep them in arch_def.h and extend?
>=20
> no because arch_def.h contains C structures and inline.

(resend because the iOS Mail app does crazy html thingies)

You=E2=80=98re looking for

#ifndef __ASSEMBLER__
...

See lib/s390x/asm/sigp.h

