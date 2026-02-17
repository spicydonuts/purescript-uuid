// module Data.UUID
import { v3, v4, v5, v7, validate, version } from "uuid";

export const getUUID3Impl = function (str) {
  return function (namespace) {
    return v3(str, namespace);
  };
};

export const getUUIDImpl = v4;

export const getUUID5Impl = function (str) {
  return function (namespace) {
    return v5(str, namespace);
  };
};

export const getUUIDv7Impl = v7;

export const validateUUID = validate;

export const uuidVersionImpl = version;
